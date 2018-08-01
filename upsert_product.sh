#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: upsert_product.sh 
# Date:    1/14/2018 
# Author:  J.Turck
# User: 
#
# Purpose: Execute passed in SQL
# 
###########################################################################################
source ${HOME}/config/init.cfg
export PGM_NAME=upsert_product


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

#####################################################################################
### Work with loading.akeneo
#####################################################################################

echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err

echo "ALTER TABLE loading.akeneo OWNER to ${ATERO_OWNER};" > ${RUNDIR}/alt_akeneo_owner.sql
echo " \COPY loading.akeneo FROM '${DATADIR}/products.csv' WITH DELIMITER AS ',' CSV HEADER NULL as ''" > ${RUNDIR}/ins_akeneo.sql
echo "UNLISTEN tblobs_default_channel;" > ${RUNDIR}/unlisten.sql

cat ${RUNDIR}/upsert_product_ss.txt |while read step
do
   echo "Running... ${step}.sql " >> ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out
   export SQL_STEP=${step}
   echo "The DB is: ${DATABASE}"
   psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${RUNDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out 2>> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
   es=${?}
      if [[ ${es} -ne 0 ]]; then
         echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
         curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} for database: ${DATABASE} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
         exit 3
      fi
done

