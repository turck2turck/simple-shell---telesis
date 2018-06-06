#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: dealer_product_base.sh
# Date:    5/10/2018
# Author:  J.Turck
# User:
#
# Purpose: Insert records to the dealer_product_base table.
#
###########################################################################################
export DEALER=$1
source /home/ubuntu/config/init.cfg
export PGM_NAME=dealer_product_base


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

echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} for ${D_NAME}" > ${LOGDIR}/${PGM_NAME}.out
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} for ${D_NAME}" > ${ELOGDIR}/${PGM_NAME}.err

export SQL_STEP=ins_dealer_product_base
while read line
do
   D_NAME=$(awk -F\| '{ print $1 }' <<< "$line")
   MFR_ABBR=$(awk -F\| '{ print $2 }' <<< "$line")
   D_PRICE=$(awk -F\| '{ print $3 }'  <<< "$line")
   echo "insert into public.dealer_product_base (dealer_org_id,product_id,buyer_price,created_at,created_by)
   select d.id, p.id, ${D_PRICE}, current_timestamp, 1
   from public.product p, public.manufacturer m , public.dealer_org d , public.manufacturer_dealer_assoc a
   where a.manufacturer_id = m.id
   and a.dealer_org_id = d.id
   and m.id = p.manufacturer_id
   and m.mfr_abbr = ${MFR_ABBR}
   and d.name = ${D_NAME} 
   and p.msrp <> 1
   ON CONFLICT (dealer_org_id, product_id) DO UPDATE
   SET product_id=EXCLUDED.product_id, buyer_price=EXCLUDED.buyer_price,updated_at=current_timestamp,updated_by=1; "> ${SQLDIR}/${SQL_STEP}.sql
   psql -h ${HOST} -U ${USER} -d ${DATABASE} -t -v "ON_ERROR_STOP=1" -f ${SQLDIR}/${SQL_PGM1} >> ${LOGDIR}/${PGM_NAME}.out 2>>${ELOGDIR}/${PGM_NAME}.err
   es=${?}
      if [[ ${es} -ne 0 ]]; then
         echo "Error with the ${SQL_PGM1} script." >>${ELOGDIR}/${PGM_NAME}.err
         curl -X POST --data-urlencode "payload={\"channel\": \"#script-messages\", \"username\": \"webhookbot\", \"text\": \"ERROR on ${DTS} in ${HOST} - /elogs/${PGM_NAME}.err - Problem with ${SQL_STEP}.sql.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
         exit 3
      fi
done < ${CONFIG}/${DEALER}_discount.cfg

exit 0
