#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: atero_driver.sh
# Date:    1/29/2018
# Author:  J.Turck
# User:
#
# Purpose: Execute the loading and updating of the Atero database.
#
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

#################################################################################################################

# Remove zero byte files
cd /home/ubuntu/export/bap; find . -type f -size 0M -name products.csv -exec dirname {} \; | xargs rm -rf

# Execute incremental export
. /home/ubuntu/akeneo-package/script/incremental-export.sh
# Execute ingestion script DEMO
. /home/ubuntu/scripts/data-team/ingestion.sh DEMO
# Execute ingestion script STG
. /home/ubuntu/scripts/data-team/ingestion.sh STG
# Execute ingestion script PRD
. /home/ubuntu/scripts/data-team/ingestion.sh PRD
# Execute QA script
# Execute s3 sync script
# Execute arhive export script



