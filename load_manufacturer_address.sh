#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: load_manufacturer_address.sh 
# Date:    2/5/2018 
# Author:  J.Turck
# User: 
#
# Purpose: Load the loading.manufacturer_address table
# 
###########################################################################################
source /home/ubuntu/scripts/data-team/init.cfg
export IN_TABLE=manufacturer_address
export PGM_NAME=load_manufacturer_address

if [[ -s ${HOME}/.pwx ]]; then
   . ${HOME}/.pwx
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

echo "TRUNCATE TABLE loading.${IN_TABLE}; " > ${SQLDIR}/tru_${IN_TABLE}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f  ${SQLDIR}/tru_${IN_TABLE}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the tru_${IN_TABLE}.sql command."
      exit 3
   fi

echo " \COPY loading.${IN_TABLE} FROM '${DATADIR}/${IN_TABLE}.csv' WITH DELIMITER AS ',' CSV HEADER NULL as ''" > ${SQLDIR}/ins_${IN_TABLE}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f  ${SQLDIR}/ins_${IN_TABLE}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
	es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_${IN_TABLE}.sql command."
      exit 3
   fi

exit 0
