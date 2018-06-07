#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: run_sql.sh
# Date:    2/5/2018
# Author:  J.Turck
# User:
#
# Purpose: Execute passed in SQL.
#
###########################################################################################
source /home/ubuntu/config/init.cfg
export RUN_THIS=$1
export PGM_NAME=run_sql.sh

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

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${RUNDIR}/${RUN_THIS} >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ${RUN_THIS} script."
      exit 3
   fi

exit 0
