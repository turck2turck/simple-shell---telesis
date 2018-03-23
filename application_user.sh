#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: application_user.sh
# Date:    3/13/2018
# Author:  J.Turck
# User:
#
# Purpose: Execute QA SQL.
#
###########################################################################################
source /home/ubuntu/scripts/data-team/init.cfg

export PGM_NAME=application_user
export cnt=1
export sql_pgm=ins_application_user.sql

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

echo "" > ${SQLDIR}/${sql_pgm}

while [ ${cnt} -le 150 ]
do
echo "insert into public.application_user (email,first_name,last_name,email_confirmed,password_hash,user_role,created_at,created_by)
values ('user@dealerorg${cnt}.com','User First Name','User last Name','N',NULL,'DEALER_ADMIN',current_timestamp,1); " >> ${SQLDIR}/${sql_pgm}
   cnt=$(( ${cnt} + 1 ))

done

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${SQLDIR}/${sql_pgm} >> ${QALOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ${sql_pgm} script."
      exit 3
   fi

exit 0
