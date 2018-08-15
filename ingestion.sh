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
PIDFILE=${HOME}/pids/export.pid
export PGM_NAME=ingestion

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

export RUN_ENV=$1
. ~/scripts/data-team/set_env.sh ${RUN_ENV}
source ${HOME}/config/init.cfg
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

echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err

echo "This is ${RUN_ENV}"

if [[ ${RUN_ENV} == PRD ]] || [[ ${RUN_ENV} == DEMO ]] ; then
   atero_exports=''

   atero_exports=$((cd ${HOME}/export/bap/atero_catalog_epurchasingnetwork_com; find . -type f -name products.csv -exec dirname {} \;) | sed 's/.//')

   echo "--------------------------------------------------------"  >>${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out
   echo "These are the atero exports: ${atero_exports}" >>${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out
   echo "--------------------------------------------------------"  >>${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out

   echo "These are the atero exports: ${atero_exports}" 

   for export_dir in ${atero_exports}
   do
      echo "Working on: ${export_dir}"
      echo "Processing US export: ${export_dir}" >>${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out
      cp ${HOME}/export/bap/atero_catalog_epurchasingnetwork_com/${export_dir}/products.csv ${DATADIR}/products.csv
      sleep 10
      . ~/scripts/data-team/upsert_product.sh
   done
fi

if [[ ${RUN_ENV} == STG ]]; then
   staging_exports=''

   staging_exports=$((cd ${HOME}/export/bap/staging_catalog_epurchasingnetwork_com; find . -type f -name products.csv -exec dirname {} \;) | sed 's/.//')

   echo "--------------------------------------------------------"  >>${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out
   echo "These are the atero exports: ${staging_exports}" >>${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out
   echo "--------------------------------------------------------"  >>${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out

   echo "These are the atero exports: ${staging_exports}"

   for export_dir in ${staging_exports}
   do
      echo "Working on: ${export_dir}"
      echo "Processing US export: ${export_dir}" >>${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out
      cp ${HOME}/export/bap/staging_catalog_epurchasingnetwork_com/${export_dir}/products.csv ${DATADIR}/products.csv
      sleep 10
      . ~/scripts/data-team/upsert_product.sh
   done
fi

. ~/scripts/data-team/check_duplicate_skus.sh

rm $PIDFILE

