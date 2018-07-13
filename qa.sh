#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: qa.sh
# Date:    3/13/2018
# Author:  J.Turck
# User:
#
# Purpose: Execute QA SQL.
#
###########################################################################################
export RUN_ENV=$1
. ~/scripts/data-team/set_env.sh ${RUN_ENV}
source /home/ubuntu/config/init.cfg
export PGM_NAME=qa
export akeneo_export=$1

if [[ -s ${HOME}/.pwx ]]; then
 . ${HOME}/.pwx
else
   echo ""
   echo ""
   echo "ERROR: password file ${HOME}/.pwx is empty or does not exist"
   echo "       processing terminating now."
   echo ""
   echo ""
   exit 99
fi

echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}.err

function check_pid() {
PIDFILE=/home/ubuntu/pids/export.pid

if [ -f $PIDFILE ]
then
  PID=$(cat $PIDFILE)
  ps -p $PID > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    echo "export or rsync process already running"
    exit 1
  else
    ## Process not found assume not running
    echo $$ > $PIDFILE
    if [ $? -ne 0 ]
    then
      echo "Could not create incremental export PID file"
      exit 1
    fi
  fi
else
  echo $$ > $PIDFILE
  if [ $? -ne 0 ]
  then
    echo "Could not create incremental-export PID file"
    exit 1
  fi
fi
}

function run_qa () {
   export RUNLOG=${QALOGDIR}/${export_dir}_${PGM_NAME}_${DTS}.out
   echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " >${RUNLOG}
   echo " " >>${RUNLOG}
   echo "-------------------------------------------------------" >>${RUNLOG}
   echo "The error log ~/elogs/upsert_product.err: " >>${RUNLOG}
   cat ~/elogs/upsert_product_${RUN_ENV}.err >> ${RUNLOG}
   echo "-------------------------------------------------------" >>${RUNLOG}
   echo " " >>${RUNLOG}
   
   echo "" > ${SQLDIR}/qa.sql
   cat ${CONFIG}/tables.txt |while read tab 
      do
         echo "Select count(*) from ${tab} ; " >> ${SQLDIR}/qa.sql
      done

   export SQL_STEP=qa
   psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >>${RUNLOG} 2>> ${ELOGDIR}/${PGM_NAME}.err
   es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the qa.sql script." >>${ELOGDIR}/${PGM_NAME}.err
   curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} for database ${DATABASE} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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

      exit 3
   fi
   export SQL_STEP=independent_query
   echo "" > ${SQLDIR}/${SQL_STEP}.sql
   echo "select sku,product_model_number,manufacturer_id from public.product where cat_sub_assoc_id is NULL and deleted_at is NULL;" >> ${SQLDIR}/${SQL_STEP}.sql
   echo "select sku,product_model_number,manufacturer_id from public.product where msrp is NULL and deleted_at is NULL;" >> ${SQLDIR}/${SQL_STEP}.sql
   echo "select sku, count(*) from product group by sku having count(*) >1 ORDER BY sku;" >> ${SQLDIR}/${SQL_STEP}.sql

   psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${RUNLOG} 2>> ${ELOGDIR}/${PGM_NAME}.err
   es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with ${SQL_STEP}.sql script." >> ${ELOGDIR}/${PGM_NAME}.err
      curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS}-${DATABASE} in ${HOST}i for database ${DATABASE} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
      exit 3
   fi
}

check_pid 
atero_exports=$((cd /home/ubuntu/export/bap/atero_catalog_epurchasingnetwork_com; find . -type f -name products.csv -exec dirname {} \;) | sed 's/.//')
echo "These are the atero exports: ${atero_exports}"
for export_dir in ${atero_exports}
do
echo "HERE."
   run_qa
done

rm $PIDFILE
