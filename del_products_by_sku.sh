#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: del_products_by_sku.sh 
# Date:    6/11/2018 
# Author:  J.Turck
# User: 
#
# Purpose: Execute passed in SQL
# 
###########################################################################################
source ${HOME}/config/init.cfg
export PGM_NAME=del_product

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
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err


cp ${DATADIR}/del_product.txt ${DATADIR}/del_product2.txt
dos2unix ${DATADIR}/del_product2.txt 
cat ${DATADIR}/del_product2.txt |sed "s/^/'/" > /tmp/1.txt
cat /tmp/1.txt |sed  "s/$/'/" > /tmp/2.txt
cat /tmp/2.txt |tr -s '\n' ',' > /tmp/3.txt
cat /tmp/3.txt |sed 's/.$//' > /tmp/4.txt
mv /tmp/4.txt ${DATADIR}/del_product2.txt

sku=`cat ${DATADIR}/del_product2.txt`

export SQL_STEP=del_product_attachment
echo "delete from public.product_attachment USING public.product p where product_id in (
      select p.id from public.product p where p.sku in (${sku})) ;" > ${SQLDIR}/${SQL_STEP}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out 2>> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
es=${?}
  if [[ ${es} -ne 0 ]]; then
     echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
     curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
     exit 3
  fi

export SQL_STEP=del_buyer_product_price
echo "delete from public.buyer_product_price
      where dealer_product_base_id IN (select d.id from public.dealer_product_base d where d.product_id in (
      select p.id FROM public.product p where p.sku in (${sku}))); " > ${SQLDIR}/${SQL_STEP}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out 2>> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
      curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
      exit 3
   fi

export SQL_STEP=del_buyer_product_price_log
echo "delete from public.buyer_product_price_log
      where dealer_product_base_id IN (select d.id from public.dealer_product_base d where d.product_id in (
      select p.id FROM public.product p where p.sku in (${sku}))); " > ${SQLDIR}/${SQL_STEP}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out 2>> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
      curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
      exit 3
   fi

export SQL_STEP=del_dealer_product_base
echo "delete from public.dealer_product_base  
      where product_id in (select p.id from public.product p where p.sku in (${sku})) "> ${SQLDIR}/${SQL_STEP}.sql
   psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out 2>> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
   es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
      curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
      exit 3
   fi

export SQL_STEP=del_product_accessory_assoc
echo "delete from public.product_accessory_assoc
      where parent_accessory_product_id IN(select p.id from public.product p where p.sku in (${sku}))
         or child_accessory_product_id IN(select p.id from public.product p where p.sku in (${sku})) ; "> ${SQLDIR}/${SQL_STEP}.sql
  psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out 2>> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
   es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
      curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
      exit 3
   fi

export SQL_STEP=del_dealer_product_log
echo "delete from public.dealer_product_log 
      where product_id in (select p.id from public.product p where p.sku in (${sku})); "> ${SQLDIR}/${SQL_STEP}.sql
   psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out 2>> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
   es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
      curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
      exit 3
   fi

export SQL_STEP=del_wishlist_item
echo "delete from public.wishlist_item 
      where product_id in (select p.id from public.product p WHERE p.sku in (${sku})); "> ${SQLDIR}/${SQL_STEP}.sql
   psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out 2>> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
   es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
      curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
      exit 3
   fi

export SQL_STEP=del_price_modifier
echo " delete from public.price_modifier
      where product_id in (select p.id from public.product p WHERE p.sku in (${sku})); "> ${SQLDIR}/${SQL_STEP}.sql
   psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out 2>> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
   es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
      curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
      exit 3
   fi
export SQL_STEP=del_product
echo "delete from public.product  
      where sku in (${sku}) ;"> ${SQLDIR}/${SQL_STEP}.sql
   psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out 2>> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
   es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
      curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
      exit 3
   fi

rm ${DATADIR}/del_product2.txt

exit 0
