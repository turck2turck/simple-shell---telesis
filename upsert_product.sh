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
source /home/ubuntu/config/init.cfg
export PGM_NAME=upsert_product


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

echo "Running ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}.err
echo "Running ${PGM_NAME} on ${DTS} in ${HOST} " > ${LOGDIR}/${PGM_NAME}.out

#####################################################################################
### Work with loading.akeneo
#####################################################################################
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${LOGDIR}/${PGM_NAME}.out
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}.err

echo "TRUNCATE TABLE loading.akeneo " > ${SQLDIR}/tru_akeneo.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f  ${SQLDIR}/tru_akeneo.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
  if [[ ${es} -ne 0 ]]; then
      echo "Error with the tru_akeneo.sql command."
      exit 3
   fi

echo " \COPY loading.akeneo FROM '${DATADIR}/products.csv' WITH DELIMITER AS ',' CSV HEADER NULL as ''" > ${SQLDIR}/ins_akeneo.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f  ${SQLDIR}/ins_akeneo.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_akeneo.sql command."
      exit 3
   fi

echo "SELECT count(*) from loading.akeneo " > ${SQLDIR}/cnt_akeneo.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f  ${SQLDIR}/cnt_akeneo.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the cnt_akeneo.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a <<EOF
ALTER TABLE loading.akeneo ADD COLUMN product_hash character varying(50) COLLATE pg_catalog."default";
ALTER TABLE loading.akeneo ADD COLUMN mfg_id integer;
ALTER TABLE loading.akeneo ADD COLUMN id integer NOT NULL DEFAULT nextval('product_id_seq'::regclass);
ALTER TABLE loading.akeneo ADD COLUMN atero_cat_id integer;
ALTER TABLE loading.akeneo ADD COLUMN variant_hash1 character varying(50) COLLATE pg_catalog."default";
ALTER TABLE loading.akeneo ADD COLUMN variant_hash2 character varying(50) COLLATE pg_catalog."default";
ALTER TABLE loading.akeneo ADD COLUMN variant_hash3 character varying(50) COLLATE pg_catalog."default";
ALTER TABLE loading.akeneo ADD COLUMN variant_hash4 character varying(50) COLLATE pg_catalog."default";
ALTER TABLE loading.akeneo ADD COLUMN variant_hash5 character varying(50) COLLATE pg_catalog."default";
ALTER TABLE loading.akeneo ADD COLUMN variant_hash6 character varying(50) COLLATE pg_catalog."default";
ALTER TABLE loading.akeneo ADD COLUMN variant_hash7 character varying(50) COLLATE pg_catalog."default";
ALTER TABLE loading.akeneo ADD COLUMN variant_hash8 character varying(50) COLLATE pg_catalog."default";
ALTER TABLE loading.akeneo ADD COLUMN variant_hash9 character varying(50) COLLATE pg_catalog."default";
ALTER TABLE loading.akeneo ADD COLUMN variant_hash10 character varying(50) COLLATE pg_catalog."default";
ALTER TABLE loading.akeneo ADD COLUMN post_msrp numeric(12,2);
ALTER TABLE loading.akeneo ADD COLUMN post_depth numeric(10,3);
ALTER TABLE loading.akeneo ADD COLUMN post_shipping_weight numeric(10,3);
ALTER TABLE loading.akeneo ADD COLUMN post_unit_of_measure character varying(50) COLLATE pg_catalog."default";

EOF

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/upd_akeneo.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the upd_akeneo.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/ins_akeneo_err.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_akeneo.sql command."
      exit 3
   fi

#####################################################################################
### Begin public.product anad associated tables
#####################################################################################

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/ins_product_product.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_product_${TABLE_NAME}.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/ins_product_accessory.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_product_accessory.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/ins_option_product.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_option_product.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/ins_variant_product.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_variant_product.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/ins_product_option_assoc.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the product_option_assoc.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/ins_product_attachment.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_product_attachement.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/ins_option_attachment.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_option_attachement.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/ins_variant_attachment.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_variant_attachement.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/ins_product_option_assoc.sql >> ${LOGDIR}/${PGM_NAME}.out 2>> ${ELOGDIR}/${PGM_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the product_option_assoc.sql command."
      exit 3
   fi


psql -h ${HOST} -U ${USER} -d ${DATABASE} -a <<EOF
ALTER TABLE loading.akeneo DROP COLUMN product_hash ;
ALTER TABLE loading.akeneo DROP COLUMN mfg_id ;
ALTER TABLE loading.akeneo DROP COLUMN id ;
ALTER TABLE loading.akeneo DROP COLUMN atero_cat_id ;
ALTER TABLE loading.akeneo DROP COLUMN variant_hash1 ;
ALTER TABLE loading.akeneo DROP COLUMN variant_hash2 ;
ALTER TABLE loading.akeneo DROP COLUMN variant_hash3 ;
ALTER TABLE loading.akeneo DROP COLUMN variant_hash4 ;
ALTER TABLE loading.akeneo DROP COLUMN variant_hash5 ;
ALTER TABLE loading.akeneo DROP COLUMN variant_hash6 ;
ALTER TABLE loading.akeneo DROP COLUMN variant_hash7 ;
ALTER TABLE loading.akeneo DROP COLUMN variant_hash8 ;
ALTER TABLE loading.akeneo DROP COLUMN variant_hash9 ;
ALTER TABLE loading.akeneo DROP COLUMN variant_hash10 ;
ALTER TABLE loading.akeneo DROP COLUMN post_msrp ;
ALTER TABLE loading.akeneo DROP COLUMN post_depth ;
ALTER TABLE loading.akeneo DROP COLUMN post_shipping_weight ;
ALTER TABLE loading.akeneo DROP COLUMN post_unit_of_measure ;
EOF


exit 0
