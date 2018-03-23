#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: su_application_user.sh
# Date:    3/23/2018
# Author:  J.Turck
# User:
#
# Purpose: Execute QA SQL.
#
###########################################################################################
export DEALER=$1
source /home/ubuntu/scripts/data-team/init.cfg
source ${CONFIG}/${DEALER}.cfg
export PGM_NAME=su_application_user
export SQL_PGM=ins_su_app_user.sql


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

echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${QALOGDIR}/${PGM_NAME}.out
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}.err

echo "insert into public.application_user (email, first_name, last_name, email_confirmed, password_hash, user_role, created_at, created_by) 
      values (${EMAIL},${FIRST_NAME},${LAST_NAME},'N',NULL,'DEALER_ADMIN',current_timestamp,1); " > ${SQLDIR}/${SQL_PGM}
psql -h ${HOST} -U ${USER} -d ${DATABASE} -t -f ${SQLDIR}/${SQL_PGM} >> ${QALOGDIR}/${PGM_NAME}.out 2>>${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ${SQL_PGM} script."
      exit 3
   fi

exit 0
