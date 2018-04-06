#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: dealer_product_base.sh 
# Date:    4/6//2018
# Author:  J.Turck
# User:
#
# Purpose: Insert dealer_product_base records.
#
###########################################################################################
source /home/ubuntu/config/init.cfg
export PGM_NAME=dealer_product_base
export SQL_PGM2=ins_dealer_product_base.sql

cp ~/config/init_stg.cfg ~/config/init.cfg

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

echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} for ${D_NAME}" > ${QALOGDIR}/${PGM_NAME}.out
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} for ${D_NAME}" > ${ELOGDIR}/${PGM_NAME}.err

echo "Truncate table public.dealer_product_base; > ${SQLDIR}/${SQL_PGM1}
psql -h ${HOST} -U ${USER} -d ${DATABASE} -t -f ${SQLDIR}/${SQL_PGM1} >> ${LOGDIR}/${PGM_NAME}.out 2>>${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ${SQL_PGM1} script."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -t -f ${SQLDIR}/${SQL_PGM2} >> ${LOGDIR}/${PGM_NAME}.out 2>>${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ${SQL_PGM2} script."
      exit 3
   fi


exit 0
