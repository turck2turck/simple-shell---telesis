
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
<<<<<<< HEAD
export PGM_NAME=load_manufacturer_address
export IN_TABLE=manufacturer_address


=======
export IN_TABLE=manufacturer_address
export PGM_NAME=load_manufacturer_address

>>>>>>> 2bf7a72d38b355222031dbbc9e93e7587d0ab957
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

echo "Truncate Table loading.${IN_TABLE} " > ${SQLDIR}/tru_${IN_TABLE}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f  ${SQLDIR}/tru_${IN_TABLE}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the tru_manufacturer_address.sql command."
      exit 3
   fi

echo "\COPY loading.manufacturer_address FROM '${DATADIR}/manufacturer_address.csv' WITH DELIMITER AS ',' CSV HEADER NULL as ''" > ${SQLDIR}/ins_man_add.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${SQLDIR}/ins_man_add.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
=======
echo "Running ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}.err
echo "Running ${PGM_NAME} on ${DTS} in ${HOST} " > ${LOGDIR}/${PGM_NAME}.out

echo "TRUNCATE TABLE loading.${IN_TABLE}; " > ${SQLDIR}/tru_${IN_TABLE}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f  ${SQLDIR}/tru_${IN_TABLE}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
>>>>>>> 2bf7a72d38b355222031dbbc9e93e7587d0ab957
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the tru_${IN_TABLE}.sql command."
      exit 3
   fi

<<<<<<< HEAD
echo "SELECT count(*) from loading.manufacturer_address " > ${SQLDIR}/cnt_man_add.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${SQLDIR}/cnt_man_add.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
=======
echo " \COPY loading.${IN_TABLE} FROM '${DATADIR}/${IN_TABLE}.csv' WITH DELIMITER AS ',' CSV HEADER NULL as ''" > ${SQLDIR}/ins_${IN_TABLE}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f  ${SQLDIR}/ins_${IN_TABLE}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
	es=${?}
>>>>>>> 2bf7a72d38b355222031dbbc9e93e7587d0ab957
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_${IN_TABLE}.sql command."
      exit 3
   fi

exit 0
