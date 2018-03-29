#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: qa.sh
# Date:    3/13/2018
# Author:  J.Turck
# User:
#
# Purpose: Execute QA SQL.
#
###########################################################################################
source /home/ubuntu/config/init.cfg

export PGM_NAME=qa
export akeneo_export=$1


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

echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${QALOGDIR}/${PGM_NAME}.out
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}.err

echo "select distinct(product_family),'XXX' from loading.akeneo" > ${SQLDIR}/product_family.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -t -f ${SQLDIR}/product_family.sql >> ${RUNDIR}/product_family.out
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the product_family.sql script."
      exit 3
   fi

echo "" > ${SQLDIR}/qa.sql
cat ${RUNDIR}/tables.txt |while read tab 
do
   echo "Select count(*) from ${tab} ; " >> ${SQLDIR}/qa.sql
done

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${SQLDIR}/qa.sql >> ${QALOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the qa.sql script."
      exit 3
   fi


## Independent Queries
echo "" > ${SQLDIR}/independent_query.sql
echo "select sku from public.product where cat_sub_assoc_id is NULL;" >> ${SQLDIR}/independent_query.sql
echo "select sku from public.product where msrp is NULL ;" >> ${SQLDIR}/independent_query.sql
#echo "select product_model_number, name from public.product where product_family = upper('${product_family_run}');" >> ${SQLDIR}/independent_query.sql

#echo "select p.product_model_number AS product, p.description AS Product_description, o.product_model_number AS option_product, o.description AS Option_description  from public.product_option_assoc a, public.product p, public.option_product o where a.parent_product_id = p.id and a.type_flag ='P'  and a.child_product_id = o.id order by p.product_model_number;" >> ${SQLDIR}/independent_query.sql

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${SQLDIR}/independent_query.sql >> ${QALOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the independent_query.sql script."
      exit 3
   fi

mv ${QALOGDIR}/${PGM_NAME}.out ${QALOGDIR}/${PGM_NAME}_${akeneo_export}_${DTS}.out

exit 0
