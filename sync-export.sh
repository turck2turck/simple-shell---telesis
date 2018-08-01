#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: sync-export.sh
# Date:    
# Author: 
# User:
#
# Purpose: Copy files to S3.
#
# Usage:   Called from cron.
###########################################################################################
export PGM_NAME=sync-export
PIDFILE=${HOME}/pids/export.pid
ATERO_S3=s3://atero/attachment/
source ${HOME}/config/init.cfg
EPN_MFG_ID=bap

RUN_ENV=$1

files=$(ls ${HOME}/export.pid 2> /dev/null | wc -l)
if [ "$files" != "0" ]
then
  echo "other export or sync processes running"
  exit 1
fi

if [ -f $PIDFILE ]
then
  PID=$(cat $PIDFILE)
  ps -p $PID > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    echo "sync-export process already running"
    exit 1
  else
    ## Process not found assume not running
    echo $$ > $PIDFILE
    if [ $? -ne 0 ]
    then
      echo "Could not create sync-export PID file"
      exit 1
    fi
  fi
else
  echo $$ > $PIDFILE
  if [ $? -ne 0 ]
  then
    echo "Could not create sync-export PID file"
    exit 1
  fi
fi

echo "Executing ${PGM_NAME} on ${DTS} " > ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out
echo "Executing ${PGM_NAME} on ${DTS} " > ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err


#target_exports=$((cd ${HOME}/export/bap; find . -type f -name products.csv -exec dirname {} \;) | sed 's/.//')
#atero_exports=$((cd ${HOME}/export/bap/atero_catalog_epurchasingnetwork_com; find . -type f -name products.csv -exec dirname {} \;) | sed 's/.//')
#staging_exports=$((cd ${HOME}/export/bap/staging_catalog_epurchasingnetwork_com; find . -type f -name products.csv -exec dirname {} \;) | sed 's/.//')

if [[ ${RUN_ENV} == PRD ]]; then
   echo "--------------------------------------------------------" >> ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out

   atero_exports=$((cd ${HOME}/export/bap/atero_catalog_epurchasingnetwork_com; find . -type f -name products.csv -exec dirname {} \;) | sed 's/.//')

   for export_dir in ${atero_exports}
   do
      echo "Processing Atero: ${export_dir} " >> ${LOGDIR}/${PGM_NAME}.out
      /usr/local/bin/aws s3 sync ${HOME}/export/bap/atero_catalog_epurchasingnetwork_com${export_dir} ${ATERO_S3} --size-only --acl public-read
   done
fi

if [[ ${RUN_ENV} == STG ]]; then
   echo "--------------------------------------------------------" >> ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out

   staging_exports=$((cd ${HOME}/export/bap/staging_catalog_epurchasingnetwork_com; find . -type f -name products.csv -exec dirname {} \;) | sed 's/.//')

   for export_dir in ${staging_exports}
   do
      echo "Processing Staging: ${export_dir} " >> ${LOGDIR}/${PGM_NAME}.out
      /usr/local/bin/aws s3 sync ${HOME}/export/bap/staging_catalog_epurchasingnetwork_com${export_dir} ${ATERO_S3} --size-only --acl public-read
   done
fi

echo "${PGM_NAME}.sh complete $('date')" >> ${LOGDIR}/${PGM_NAME}.out


rm $PIDFILE
