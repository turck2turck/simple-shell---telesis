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
source /home/ubuntu/config/init.cfg
export PGM_NAME=load_manufacturer_address
export IN_TABLE=manufacturer_address

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

echo "Truncate Table loading.${IN_TABLE} " > ${SQLDIR}/tru_${IN_TABLE}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f  ${SQLDIR}/tru_${IN_TABLE}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the tru_manufacturer_address.sql command."
      exit 3
   fi

echo "\COPY loading.manufacturer_address FROM '${DATADIR}/manufacturer_address.csv' WITH DELIMITER AS ',' CSV HEADER NULL as ''" > ${SQLDIR}/ins_man_add.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${SQLDIR}/ins_man_add.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the tru_${IN_TABLE}.sql command."
      exit 3
   fi

echo "SELECT count(*) from loading.manufacturer_address " > ${SQLDIR}/cnt_man_add.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${SQLDIR}/cnt_man_add.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
	es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_${IN_TABLE}.sql command."
      exit 3
   fi

exit 0
