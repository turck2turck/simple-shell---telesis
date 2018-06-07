#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: ingestion.sh
# Date:    6/7/2018
# Author:  J.Turck
# User:
#
# Purpose: Load the exported Akeneo data to the Atero databases.
#
# Usage:   Called from cron.
###########################################################################################
export RUNENV=$1
. ~/scripts/data-team/set_env.sh ${RUNENV}
source /home/ubuntu/config/init.cfg
export PGM_NAME=ingestion

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

echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${LOGDIR}/${PGM_NAME}.out
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}.err

atero_exports=$((cd /home/ubuntu/export/bap/atero_catalog_epurchasingnetwork_com; find . -type f -name products.csv -exec dirname {} \;) | sed 's/.//')
aterocan_exports=$((cd /home/ubuntu/export/bap/aterocan_catalog_epurchasingnetwork_com; find . -type f -name products.csv -exec dirname {} \;) | sed 's/.//')


echo "--------------------------------------------------------"
echo "These are the atero exports: ${atero_exports}" >>${LOGDIR}/${PGM_NAME}.out
echo "These are the aterocan exports: ${aterocan_exports}" >>${LOGDIR}/${PGM_NAME}.out

for export_dir in ${atero_exports}
do
   . ~/scripts/data-team/upsert_product.sh
   echo "These are the atero exports: ${atero_exports}" 
   export_name=`echo ${export_dir}`
   mv ~/export/bap/atero_catalog_epurchasingnetwork_com${export_dir}/products.csv ~/export/atero/archive/${export_name}.products.csv.${DTS}
   echo "products.csv file moved to: ~/export/atero/archive/${export_name}.products.csv.${DTS}" >>${LOGDIR}/${PGM_NAME}.out
done

 
for canexport_dir in ${aterocan_exports}
do
   .~/scripts/data-team/upsert_products.sh
   echo "These are the aterocan exports: ${aterocan_exports}" 
   export_name=`echo ${canexport_dir}`
   mv ~/export/bap/aterocan_catalog_epurchasingnetwork_com${export_dir}/products.csv ~/export/atero/archive/${export_name}.products.csv.${DTS}
   echo "products.csv file moved to: ~/export/atero/archive/${export_name}.products.csv.${DTS}" >>${LOGDIR}/${PGM_NAME}.out
done

. ~/scripts/data-team/check_duplicate_skus.sh
exit 0
