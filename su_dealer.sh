#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: su_dealer.sh
# Date:    3/13/2018
# Author:  J.Turck
# User:
#
# Purpose: Execute QA SQL.
#
###########################################################################################
export DEALER=$1
source /home/ubuntu/config/init.cfg
source ${CONFIG}/${DEALER}.cfg
export PGM_NAME=su_dealer
export SQL_PGM1=ins_su_dealer_org.sql
export SQL_PGM2=ins_su_application_user.sql
export SQL_PGM3=ins_su_dealer.sql
export SQL_PGM4=ins_su_manufacturer_dealer_assoc.sql

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

echo "insert into public.dealer_org (name,logo,support_email,is_credit_enabled,credit_period_value,credit_amount,created_at,created_by) 
      values (${D_NAME},${D_LOGO},${D_SUPPORT_EMAIL},${D_IS_CREDIT},${D_CREDIT_PERIOD},${D_CREDIT_AMT},current_timestamp,1);" > ${SQLDIR}/${SQL_PGM1}
psql -h ${HOST} -U ${USER} -d ${DATABASE} -t -f ${SQLDIR}/${SQL_PGM1} >> ${LOGDIR}/${PGM_NAME}.out 2>>${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ${SQL_PGM1} script."
      exit 3
   fi

echo "insert into public.application_user (email, first_name, last_name, email_confirmed, password_hash, user_role, created_at, created_by)
      values (${EMAIL},${FIRST_NAME},${LAST_NAME},'N',NULL,'DEALER_ADMIN',current_timestamp,1); " > ${SQLDIR}/${SQL_PGM2}
psql -h ${HOST} -U ${USER} -d ${DATABASE} -t -f ${SQLDIR}/${SQL_PGM2} >> ${LOGDIR}/${PGM_NAME}.out 2>>${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ${SQL_PGM2} script."
      exit 3
   fi

echo "insert into public.dealer (application_user_id,dealer_org_id,is_banned,created_at,created_by)
      select a.id,d.id,'false',current_timestamp,'1'
      from public.application_user a, public.dealer_org d
      where d.name=${D_NAME} and a.email=${EMAIL} " > ${SQLDIR}/${SQL_PGM3}
psql -h ${HOST} -U ${USER} -d ${DATABASE} -t -f ${SQLDIR}/${SQL_PGM3} >> ${LOGDIR}/${PGM_NAME}.out 2>>${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ${SQL_PGM3} script."
      exit 3
   fi

cat ${CONFIG}/${DEALER}_mfr.cfg |while read i 
do
   echo "insert into public.manufacturer_dealer_assoc (manufacturer_id,dealer_org_id)
         select m.id, d.id
         from public.manufacturer m, public.dealer_org d
         where d.name=${D_NAME} and m.mfr_abbr=${i}" > ${SQLDIR}/${SQL_PGM4}
   psql -h ${HOST} -U ${USER} -d ${DATABASE} -t -f ${SQLDIR}/${SQL_PGM4} >> ${LOGDIR}/${PGM_NAME}.out 2>>${ELOGDIR}/${PGM_NAME}.err
   es=${?}
      if [[ ${es} -ne 0 ]]; then
         echo "Error with the ${SQL_PGM4} script."
         exit 3
      fi	
done

exit 0
