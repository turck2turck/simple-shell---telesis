#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: ingestion.sh
# Date:    6/7/2018
# Author:  J.Turck
# User:
#
# Purpose: Load the exported Akeneo data to the Atero databases.
#
# Usage:   Called from cron.
###########################################################################################
PIDFILE=/home/ubuntu/pids/export.pid

if [ -f $PIDFILE ]
then
  PID=$(cat $PIDFILE)
  ps -p $PID > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    echo "Export or sync process already running"
    exit 1
  else
    ## Process not found assume not running
    echo $$ > $PIDFILE
    if [ $? -ne 0 ]
    then
      echo "Could not create export PID file"
      exit 1
    fi
  fi
else
  echo $$ > $PIDFILE
  if [ $? -ne 0 ]
  then
    echo "Could not create export PID file"
    exit 1
  fi
fi

export RUNENV=$1
. ~/scripts/data-team/set_env.sh ${RUNENV}
source /home/ubuntu/config/init.cfg
export PGM_NAME=ingestion

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

echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${LOGDIR}/${PGM_NAME}_${RUNENV}.out
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}.err
atero_exports=''
aterocan_exports=''

atero_exports=$((cd /home/ubuntu/export/bap/atero_catalog_epurchasingnetwork_com; find . -type f -name products.csv -exec dirname {} \;) | sed 's/.//')
aterocan_exports=$((cd /home/ubuntu/export/bap/aterocan_catalog_epurchasingnetwork_com; find . -type f -name products.csv -exec dirname {} \;) | sed 's/.//')

echo "--------------------------------------------------------"  >>${LOGDIR}/${PGM_NAME}.out
echo "These are the atero exports: ${atero_exports}" >>${LOGDIR}/${PGM_NAME}.out
echo "These are the aterocan exports: ${aterocan_exports}" >>${LOGDIR}/${PGM_NAME}.out
echo "--------------------------------------------------------"  >>${LOGDIR}/${PGM_NAME}.out

echo "These are the atero exports: ${atero_exports}" 
echo "These are the aterocan exports: ${aterocan_exports}" 

for export_dir in ${atero_exports}
do
echo "Working on: ${export_dir}"
   echo "Processing US export: ${export_dir}" >>${LOGDIR}/${PGM_NAME}_${RUNENV}.out
   cp /home/ubuntu/export/bap/atero_catalog_epurchasingnetwork_com/${export_dir}/products.csv ~/export/atero/products.csv
   sleep 10
   . ~/scripts/data-team/upsert_product.sh
done

 
for canexport_dir in ${aterocan_exports}
do
echo "Working on: ${canexport_dir}"
   echo "Processing Canada export: ${canexport_dir}" >>${LOGDIR}/${PGM_NAME}_${RUNENV}.out
   cp /home/ubuntu/export/bap/aterocan_catalog_epurchasingnetwork_com/${export_dir}/products.csv ~/export/atero/products.csv
   sleep 10
   . ~/scripts/data-team/upsert_products.sh
done

. ~/scripts/data-team/check_duplicate_skus.sh

rm $PIDFILE

