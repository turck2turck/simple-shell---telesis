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

export SQL_STEP=tru_manufacturer_address
echo "Truncate Table loading.${IN_TABLE} " > ${SQLDIR}/${SQL_STEP}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with ${SQL_STEP}.sql." >> ${ELOGDIR}/${PGM_NAME}.err
      curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
      exit 3
   fi

export SQL_STEP=ins_man_add
echo "\COPY loading.manufacturer_address FROM '${DATADIR}/manufacturer_address.csv' WITH DELIMITER AS ',' CSV HEADER NULL as ''" > ${SQLDIR}/${SQL_STEP}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/ins_man_add.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the tru_${IN_TABLE}.sql command." >> ${ELOGDIR}/${PGM_NAME}.err
      curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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

      exit 3
   fi
export SQL_STEP=cnt_man_add
echo "SELECT count(*) from loading.manufacturer_address " > ${SQLDIR}/${SQL_STEP}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
	es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}.err
      curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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

      exit 3
   fi

exit 0
