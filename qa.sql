#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: qa.sh
# Date:    2/5/2018
# Author:  J.Turck
# User:
#
# Purpose: Execute QA.
#
###########################################################################################
source /home/ubuntu/scripts/data-team/init.cfg

export PGM_NAME=qa

if [[ -s ${HOME}/.pwa ]]; then
 . ${HOME}/.pwa
else
   echo ""
   echo ""
   echo "ERROR: password file ${HOME}/.pwa is empty or does not exist"
   echo "       processing terminating now."
   echo ""
   echo ""
   exit 99
fi

echo "Running ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}.err
echo "Running ${PGM_NAME} on ${DTS} in ${HOST} " > ${LOGDIR}/${PGM_NAME}.out


psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f  ${RUNDIR}/${RUN_THIS} >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ${RUN_THIS} script."
      exit 3
   fi

exit 0
