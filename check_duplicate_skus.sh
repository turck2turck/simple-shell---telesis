#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: check_duplicate_skus.sh
# Date:    6/7/2018
# Author:  J.Turck
# User:
#
# Purpose: Execute SQL to check for duplicate skus in the database.
#
###########################################################################################
source /home/ubuntu/config/init.cfg
export PGM_NAME=check_duplicate_skus

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

echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${LOGDIR}/${PGM_NAME}.out
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}.err

export SQL_STEP=lst_duplicate_skus.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${RUNDIR}/${SQL_STEP} >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ${RUN_THIS} script."
      exit 3
   fi

function post_to_slack () {
  # format message as a code block ```${msg}```
  SLACK_MESSAGE=`cat ${LOGDIR}/${PGM_NAME}.out`
  SLACK_URL=https://hooks.slack.com/services/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
 
  case "$2" in
    INFO)
      SLACK_ICON=':slack:'
      ;;
    WARNING)
      SLACK_ICON=':warning:'
      ;;
    ERROR)
      SLACK_ICON=':bangbang:'
      ;;
    *)
      SLACK_ICON=':slack:'
      ;;
  esac

curl -X POST --data "payload={\"text\": \"${SLACK_ICON} ${SLACK_MESSAGE}\"}" ${SLACK_URL} 
}

post_to_slack "Check for duplicate SKUs"

