#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: batch_hard_value_price.sh
# Date:    7/16/2018
# Author:  J.Turck
# User:
#
# Purpose: Set hard value prices after loading/updating of new products in case the MSRP
#          has changed. 
#
# Usage:   Called from cron.
###########################################################################################
source /home/ubuntu/config/init_prd.cfg
cp ${HOME}/.pwp ${HOME}/.pwx
export PGM_NAME=batch_hard_value_price


export RUN_ENV=PRD

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

echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err

## Run dealer_product_base net cost pricing.
export SQL_STEP=dealer_product_base_nc
echo "insert into public.dealer_product_base (dealer_org_id, product_id, net_cost, retail_hidden, retail_can_purchase, buyers_hidden, buyers_can_purchase,created_at, created_by)
select x.dealer_org_id, p.id, (x.net_cost/p.msrp)*100, 'false', 'true', 'false', 'true', current_timestamp, 1
from public.product p, loading.batch_dealer_product_base_nc x, public.manufacturer m
where x.product_model_number = p.product_model_number and x.mfr_abbr = m.mfr_abbr and p.manufacturer_id = m.id and p.msrp <> 1
ON CONFLICT (dealer_org_id, product_id) DO UPDATE
set net_cost=EXCLUDED.net_cost, updated_at=current_timestamp, updated_by=1 " > ${SQLDIR}/${SQL_STEP}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out 2>> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
es=${?}
  if [[ ${es} -ne 0 ]]; then
     echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
     curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
     exit 3
  fi


## Run dealer_product_base showroom pricing.
export SQL_STEP=dealer_product_base_bp
echo "insert into public.dealer_product_base (dealer_org_id, product_id, buyer_price, retail_hidden, retail_can_purchase, buyers_hidden, buyers_can_purchase,created_at, created_by)
select x.dealer_org_id, p.id, (x.buyer_price/p.msrp)*100, 'false', 'true', 'false', 'true', current_timestamp, 1
from public.product p, loading.batch_dealer_product_base_bp x, public.manufacturer m
where x.product_model_number = p.product_model_number and x.mfr_abbr = m.mfr_abbr and p.manufacturer_id = m.id and p.msrp <> 1
ON CONFLICT (dealer_org_id, product_id) DO UPDATE
set buyer_price=EXCLUDED.buyer_price, updated_at=current_timestamp, updated_by=1 " > ${SQLDIR}/${SQL_STEP}.sql 
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out 2>> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
es=${?}
  if [[ ${es} -ne 0 ]]; then
     echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
     curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
     exit 3
  fi

## Run buyer spicific pricing
export SQL_STEP=buyer_price_dpb
echo "insert into public.dealer_product_base (dealer_org_id, product_id, retail_hidden,retail_can_purchase,buyers_hidden, buyers_can_purchase,created_at, created_by)
select x.dealer_org_id, p.id, 'false', 'true', 'false', 'true', current_timestamp, 1
from public.product p, loading.batch_buyer_product_price_p x, public.manufacturer m
where x.product_model_number = p.product_model_number and x.mfr_abbr = m.mfr_abbr and p.manufacturer_id = m.id and p.msrp<> 1
ON CONFLICT (dealer_org_id, product_id) DO NOTHING; "> ${SQLDIR}/${SQL_STEP}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out 2>> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
es=${?}
  if [[ ${es} -ne 0 ]]; then
     echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
     curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
     exit 3
  fi

export SQL_STEP=buyer_price_bpp
echo "insert into public.buyer_product_price (buyer_org_id,dealer_product_base_id,dealer_org_id,price,hidden_override,can_purchase_override)
select x.buyer_org_id,d.id,x.dealer_org_id,(x.price/p.msrp)*100,false,true
from loading.batch_buyer_product_price_p x, public.dealer_product_base d, public.product p, public.manufacturer m
where x.mfr_abbr = m.mfr_abbr and x.product_model_number = p.product_model_number and x.dealer_org_id = d.dealer_org_id and p.manufacturer_id = m.id 
  and d.product_id = p.id and p.msrp <> 1
ON CONFLICT (buyer_org_id,dealer_product_base_id,dealer_org_id)  DO UPDATE set price=EXCLUDED.price ;  "> ${SQLDIR}/${SQL_STEP}.sql 
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_STEP}.sql >> ${LOGDIR}/${PGM_NAME}_${RUN_ENV}.out 2>> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
es=${?}
  if [[ ${es} -ne 0 ]]; then
     echo "Error with ${SQL_STEP}.sql command." >> ${ELOGDIR}/${PGM_NAME}_${RUN_ENV}.err
     curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
     exit 3
  fi

exit 0  
