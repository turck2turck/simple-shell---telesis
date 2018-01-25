#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: upsert_product.sh 
# Date:    1/14/2018 
# Author:  J.Turck
# User: 
#
# Purpose: Execute passed in SQL
# 
###########################################################################################
source /home/ubuntu/scripts/data-team/init.cfg

#-----------------------------------------------
#  Main:
#-----------------------------------------------

echo "Insert and Update public.product on ${DTS} " > ${LOGDIR}/upsert_product.out
echo "Insert and Update ERRORS for public.product on ${DTS} " > ${ELOGDIR}/upsert_product.err
echo "HOST is: ${HOST}" >> ${LOGDIR}/upsert_product.out
echo "USER is: ${USER}" >> ${LOGDIR}/upsert_product.out
echo "Database is ${DATABASE}" >> ${LOGDIR}/upsert_product.out
echo "Passord is ${PGPASSWORD}" >> ${LOGDIR}/upsert_product.out

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a <<EOF
ALTER TABLE loading.akeneo ADD COLUMN product_hash character varying(50) COLLATE pg_catalog."default";
ALTER TABLE loading.akeneo ADD COLUMN mfg_id integer;
ALTER TABLE loading.akeneo ADD COLUMN id integer NOT NULL DEFAULT nextval('product_id_seq'::regclass);
EOF

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/upd_akeneo.sql >> ${LOGDIR}/upsert_product.out 2>> ${ELOGDIR}/upsert_product.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the upd_akeneo.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/ins_akeneo_err.sql >> ${LOGDIR}/upsert_product.out 2>> ${ELOGDIR}/upsert_product.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_akeneo.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/ins_product_product.sql >> ${LOGDIR}/upsert_product.out 2>> ${ELOGDIR}/upsert_product.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_product_product.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/ins_product_accessory.sql >> ${LOGDIR}/upsert_product.out 2>> ${ELOGDIR}/upsert_product.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_product_accessory.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/ins_product_option.sql >> ${LOGDIR}/upsert_product.out 2>> ${ELOGDIR}/upsert_product.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_product_option.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/upd_product.sql >> ${LOGDIR}/upsert_product.out 2>> ${ELOGDIR}/upsert_product.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the upd_product.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/product_attachment.sql >> ${LOGDIR}/upsert_product.out 2>> ${ELOGDIR}/upsert_product.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the product_attachemant.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/product_association.sql >> ${LOGDIR}/upsert_product.out 2>> ${ELOGDIR}/upsert_product.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the product_association.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a <<EOF
ALTER TABLE loading.akeneo DROP COLUMN product_hash ;
ALTER TABLE loading.akeneo DROP COLUMN mfg_id ;
ALTER TABLE loading.akeneo DROP COLUMN id ;
EOF



exit 0


