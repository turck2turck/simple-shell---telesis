#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: del_products_by_mo.sh 
# Date:    6/11/2018 
# Author:  J.Turck
# User: 
#
# Purpose: Execute passed in SQL
# 
###########################################################################################
source ${HOME}/config/init.cfg
export PGM_NAME=del_products_by_mo
export MFR_ABBR=$1

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

#####################################################################################
### Work with loading.akeneo
#####################################################################################
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${LOGDIR}/${PGM_NAME}.out
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}.err


cp ${DATADIR}/del_product.txt ${DATADIR}/del_product2.txt
dos2unix ${DATADIR}/del_product2.txt 
cat ${DATADIR}/del_product2.txt |sed "s/^/'/" > /tmp/1.txt
cat /tmp/1.txt |sed  "s/$/'/" > /tmp/2.txt
cat /tmp/2.txt |tr -s '\n' ',' > /tmp/3.txt
cat /tmp/3.txt |sed 's/.$//' > /tmp/4.txt
mv /tmp/4.txt ${DATADIR}/del_product2.txt

model_no=`cat ${DATADIR}/del_product2.txt`
D_MFR_ABBR=`echo "'${MFR_ABBR}'"`

export SQL_STEP=del_product_attachment
echo "delete from public.product_attachment USING public.product p where product_id in (
      select p.id from public.product p, public.manufacturer m where p.product_model_number in (${model_no}) and p.manufacturer_id = m.id and m.mfr_abbr = ${D_MFR_ABBR});" > ${SQLDIR}/${SQL_STEP}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
  if [[ ${es} -ne 0 ]]; then
     echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}.err
     curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
     exit 3
  fi

export SQL_STEP=del_buyer_product_price
echo "delete from public.buyer_product_price
      where dealer_product_base_id IN (select d.id from public.dealer_product_base d where d.product_id in (
      select p.id FROM public.product p, public.manufacturer m where p.product_model_number in (${model_no})
      and p.manufacturer_id = m.id and m.mfr_abbr = ${D_MFR_ABBR})); "> ${SQLDIR}/${SQL_STEP}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}.err
      curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
      exit 3
   fi

export SQL_STEP=del_dealer_product_base
echo "delete from public.dealer_product_base  
      where product_id in (select p.id from public.product p, public.manufacturer m where p.product_model_number in (${model_no})
      and p.manufacturer_id = m.id and m.mfr_abbr = ${D_MFR_ABBR}); "> ${SQLDIR}/${SQL_STEP}.sql
   psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
   es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}.err
      curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
      exit 3
   fi

export SQL_STEP=del_dealer_product_log
echo "delete from public.dealer_product_log 
      where product_id in (select p.id from public.product p, public.manufacturer m where p.product_model_number in (${model_no})
      and p.manufacturer_id = m.id and m.mfr_abbr = ${D_MFR_ABBR}); "> ${SQLDIR}/${SQL_STEP}.sql
   psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
   es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}.err
      curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
      exit 3
   fi

export SQL_STEP=del_wishlist_item
echo "delete from public.wishlist_item 
      where product_id in (select p.id from public.product p, public.manufacturer m WHERE p.product_model_number in (${model_no})
      and p.manufacturer_id = m.id and m.mfr_abbr = ${D_MFR_ABBR}); "> ${SQLDIR}/${SQL_STEP}.sql
   psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
   es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}.err
      curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
      exit 3
   fi

export SQL_STEP=del_product
echo "delete from public.product using public.manufacturer m 
      where product_model_number in (${model_no}) and manufacturer_id = m.id and m.mfr_abbr = ${D_MFR_ABBR};"> ${SQLDIR}/${SQL_STEP}.sql
   psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
   es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}.err
      curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
      exit 3
   fi

rm ${DATADIR}/del_product2.txt

exit 0
