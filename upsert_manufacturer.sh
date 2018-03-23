#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: upsert_manufacturer.sh 
# Date:    2/5/2018 
# Author:  J.Turck
# User: 
#
# Purpose: insert or update records in the public.address table.
# 
###########################################################################################
source /home/ubuntu/scripts/data-team/init.cfg

export TABLE_NAME=manufacturer
export IN_TABLE=manufacturer_address
export PGM_NAME=upsert_manufacturer

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

<<<<<<< HEAD
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${LOGDIR}/${PGM_NAME}.out
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}.err

=======
>>>>>>> 2bf7a72d38b355222031dbbc9e93e7587d0ab957
echo "SELECT count(*) from public.${TABLE_NAME} " > ${SQLDIR}/cnt_${TABLE_NAME}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${SQLDIR}/cnt_${TABLE_NAME}.sql >> ${LOGDIR}/upsert_${TABLE_NAME}.out 2>> ${ELOGDIR}/upsert_${TABLE_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the cnt_${TABLE_NAME}.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/ins_${TABLE_NAME}.sql >> ${LOGDIR}/upsert_${TABLE_NAME}.out 2>> ${ELOGDIR}/upsert_${TABLE_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_${TABLE_NAME}.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${SQLDIR}/cnt_${TABLE_NAME}.sql >> ${LOGDIR}/upsert_${TABLE_NAME}.out 2>> ${ELOGDIR}/upsert_${TABLE_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the cnt_${TABLE_NAME}.sql command."
      exit 3
   fi

exit 0
