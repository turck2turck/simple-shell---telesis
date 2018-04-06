#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: su_demo_dealer.sh
# Date:    04/05/2018
# Author:  J.Turck
# User:
#
# Purpose: Execute QA SQL.
#
###########################################################################################
export DEALER=$1
source /home/ubuntu/config/init.cfg
export PGM_NAME=showcase_dealer
export SQL_PGM1=tru_manufacturer_dealer_assoc.sql
export SQL_PGM4=ins_su_manufacturer_dealer_assoc.sql

cp ~/config/init_demo.cfg ~/config/init.cfg

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

cat ${DATADIR}/${DEALER}.txt |dos2unix >${CONFIG}/${DEALER}.cfg
cat ${DATADIR}/${DEALER}_mfr.txt |dos2unix >${CONFIG}/${DEALER}_mfr.cfg
source ${CONFIG}/${DEALER}.cfg

echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} for ${D_NAME}" > ${QALOGDIR}/${PGM_NAME}.out
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} for ${D_NAME}" > ${ELOGDIR}/${PGM_NAME}.err


echo "truncate table public.manufacturer_dealer_assoc"> ${SQLDIR}/${SQL_PGM1} 
   psql -h ${HOST} -U ${USER} -d ${DATABASE} -t -f ${SQLDIR}/${SQL_PGM1} >> ${LOGDIR}/${PGM_NAME}.out 2>>${ELOGDIR}/${PGM_NAME}.err
   es=${?}
      if [[ ${es} -ne 0 ]]; then
         echo "Error with the ${SQL_PGM1} script."
         exit 3
      fi


cat ${CONFIG}/${DEALER}_mfr.cfg |while read i 
do
   echo "insert into public.manufacturer_dealer_assoc (manufacturer_id,dealer_org_id)
         select m.id, d.id
         from public.manufacturer m, public.dealer_org" > ${SQLDIR}/${SQL_PGM4} psql -h ${HOST} -U ${USER} -d ${DATABASE} -t -f ${SQLDIR}/${SQL_PGM4} >> ${LOGDIR}/${PGM_NAME}.out 2>>${ELOGDIR}/${PGM_NAME}.err
   es=${?}
      if [[ ${es} -ne 0 ]]; then
         echo "Error with the ${SQL_PGM4} script."
         exit 3
      fi	
done

exit 0
