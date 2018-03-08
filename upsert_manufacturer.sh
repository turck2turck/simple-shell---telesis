#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: upsert_manufacturer.sh
# Date:    2/5/2018
# Author:  J.Turck
# User:
#
# Purpose: insert or update records in the public.manufacturer table.
#
###########################################################################################
source /home/ubuntu/scripts/data-team/init.dev.cfg

export TABLE_NAME=manufacturer
export LOAD_TABLE=manufacturer_address

if [[ -s ${HOME}/.pwa ]]; then
   . ${HOME}/.pwa
else
   echo ""
   echo ""
   echo "ERROR: password file ${HOME}/.pwa is empty or does not exist"
   echo "       processing terminating now."
   echo ""
   echo ""
   exit 99
fi


echo "SELECT count(*) from public.${TABLE_NAME} " > ${SQLDIR}/cnt_${TABLE_NAME}.sql
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f  ${SQLDIR}/cnt_${TABLE_NAME}.sql >> ${LOGDIR}/upsert_${TABLE_NAME}.out 2>> ${ELOGDIR}/upsert_${TABLE_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the cnt_${TABLE_NAME}.sql command."
      exit 3
   fi

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a <<EOF
ALTER TABLE loading.${LOAD_TABLE} ADD COLUMN address_hash character varying(50) COLLATE pg_catalog."default";
ALTER TABLE loading.${LOAD_TABLE} ADD COLUMN mfr_id integer;
ALTER TABLE loading.${LOAD_TABLE} ADD COLUMN id serial;
EOF

psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/ins_${TABLE_NAME}.sql >> ${LOGDIR}/upsert_${TABLE_NAME}.out 2>> ${ELOGDIR}/upsert_${TABLE_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ins_${TABLE_NAME}.sql command."
      exit 3
   fi


psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${RUNDIR}/upd_${LOAD_TABLE}.sql >> ${LOGDIR}/upsert_${TABLE_NAME}.out 2>> ${ELOGDIR}/upsert_${TABLE_NAME}.err
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the upd_${LOAD_TABLE}.sql command."
      exit 3
   fi

exit 0
