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
source ${HOME}/config/init.cfg
export PGM_NAME=su_dealer

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


export SQL_STEP=ins_su_dealer_org
echo "insert into public.dealer_org (name,logo,support_email,is_credit_enabled,credit_period_value,credit_amount,created_at,created_by,dealer_display_name, public_retail_site) 
      values (${D_NAME},${D_LOGO},${D_SUPPORT_EMAIL},${D_IS_CREDIT},${D_CREDIT_PERIOD},${D_CREDIT_AMT},current_timestamp,1,${D_DISPLAY_NAME},'public') ON CONFLICT (name) DO NOTHING; " > ${SQLDIR}/${SQL_STEP}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -t -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>>${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with ${SQL_STEP}.sql"
      curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
      exit 3
   fi

export SQL_STEP=ins_su_dealer
echo "insert into public.dealer (application_user_id,dealer_org_id,is_banned,created_at,created_by)
      select a.id,d.id,'false',current_timestamp,'1'
      from public.application_user a, public.dealer_org d
      where d.name=${D_NAME} and a.email=${EMAIL} " > ${SQLDIR}/${SQL_STEP}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -t -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>>${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ${SQL_STEP}.sql"
     curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
      exit 3
   fi

export SQL_STEP=del_manufacturer_dealer_assoc
echo "delete from public.manufacturer_dealer_assoc 
      where dealer_org_id in (select id from public.dealer_org where name=${D_NAME}) "> ${SQLDIR}/${SQL_STEP}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -t -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>>${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ${SQL_STEP}.sql"
      curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
      exit 3
   fi	

export SQL_STEP=ins_manufacturer_dealer_assoc
cat ${CONFIG}/${DEALER}_mfr.cfg |while read i 
do
   echo "insert into public.manufacturer_dealer_assoc (manufacturer_id,dealer_org_id)
         select m.id, d.id
         from public.manufacturer m, public.dealer_org d
         where d.name=${D_NAME} and m.mfr_abbr=${i}" > ${SQLDIR}/${SQL_STEP}.sql
   psql -h ${HOST} -U ${USER} -d ${DATABASE} -t -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>>${ELOGDIR}/${PGM_NAME}.err
   es=${?}
      if [[ ${es} -ne 0 ]]; then
         echo "Error with the ${SQL_STEP}.sql"
         exit 3
      fi	
done

export SQL_STEP=ins_su_application_user
echo "insert into public.application_user (email, first_name, last_name, email_confirmed, password_hash, user_role, created_at, created_by)
      values (${EMAIL},${FIRST_NAME},${LAST_NAME},'N',NULL,'DEALER_ADMIN',current_timestamp,1); " > ${SQLDIR}/${SQL_STEP}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -t -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>>${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with ${SQL_STEP}.sql"
      curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
      exit 3
   fi

exit 0
