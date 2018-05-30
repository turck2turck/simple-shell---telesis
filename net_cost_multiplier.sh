#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: net_cost_multiplier.sh
# Date:    5/21/2018 
# Author:  J.Turck
# User: 
#
# Purpose: Load the loading.net_cost_multiplier table and process the net_cost_multiplier 
#          functions.
# 
# Usage:   ./net_cost_multipplier.sh <file>
# Note:    input file must have headers
###########################################################################################
source /home/ubuntu/config/init.cfg
export PGM_NAME=net_cost_multiplier
export IN_TABLE=net_cost_multiplier
export UP_TABLE=net_cost_disocunt
export IN_FILE=$1

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
      echo "Error with the tru_${IN_TABLE}.sql command."
      exit 3
   fi

echo "Truncate Table loading.${UP_TABLE} " > ${SQLDIR}/tru_${IN_TABLE}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f  ${SQLDIR}/tru_${UP_TABLE}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the tru_${UP_TABLE}.sql command."
      exit 3
   fi

echo "\COPY loading.net_cost_multiplier FROM '${DATADIR}/${IN_FILE}' USING DELIMITERS '|' CSV HEADER NULL as ''" > ${SQLDIR}/ins_${IN_TABLE}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${SQLDIR}/ins_${IN_TABLE}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_${IN_TABLE}.sql command."
      exit 3
   fi

echo "SELECT count(*) from loading.${IN_TABLE} " > ${SQLDIR}/cnt_${IN_TABLE}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${SQLDIR}/cnt_${IN_TABLE}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
	es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the cnt_${IN_TABLE}.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/ins_net_cost_discount.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
	es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_net_cost_discount.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/ins_dealer_product_base.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
	es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_dealer_product_base.sql command."
      exit 3
   fi

exit 0
