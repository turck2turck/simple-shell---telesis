#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: arc_products.sh
# Date:    6/7/2018
# Author:  J.Turck
# User:
#
# Purpose: iArchive the processed AKeneo export directories.
#
# Usage:   Called from cron.
###########################################################################################
source /home/ubuntu/config/init.cfg
export PGM_NAME=arc_products_file

PIDFILE=/home/ubuntu/pids/export.pid
if [ -f $PIDFILE ]
then
  PID=$(cat $PIDFILE)
  ps -p $PID > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    echo "Export or sync process already running"
    exit 1
  else
    ## Process not found assume not running
    echo $$ > $PIDFILE
    if [ $? -ne 0 ]
    then
      echo "Could not create incremental export PID file"
      exit 1
    fi
  fi
else
  echo $$ > $PIDFILE
  if [ $? -ne 0 ]
  then
    echo "Could not create incremental-export PID file"
    exit 1
  fi
fi

echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${LOGDIR}/${PGM_NAME}.out
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}.err

atero_exports=$((cd /home/ubuntu/export/bap/atero_catalog_epurchasingnetwork_com; find . -type f -name products.csv -exec dirname {} \;) | sed 's/.//')
aterocan_exports=$((cd /home/ubuntu/export/bap/aterocan_catalog_epurchasingnetwork_com; find . -type f -name products.csv -exec dirname {} \;) | sed 's/.//')

for export_dir in ${atero_exports}
do
   export_name=`echo ${export_dir}`
   echo "products.csv file moved to: ~/export/atero/archive${export_name}.products.csv.${DTS}" >>${LOGDIR}/${PGM_NAME}.out
   mv ~/export/bap/atero_catalog_epurchasingnetwork_com${export_dir}/products.csv ~/export/atero/archive/${export_name}.products.csv.${DTS}
done

for canexport_dir in ${aterocan_exports}
do
   export_name=`echo ${canexport_dir}`
   echo "products.csv file moved to: ~/export/atero/archive${canexport_name}.products.csv.${DTS}" >>${LOGDIR}/${PGM_NAME}.out
   mv ~/export/bap/aterocan_catalog_epurchasingnetwork_com${canexport_dir}/products.csv ~/export/atero/archive/${export_name}.products.csv.${DTS}
done

rm $PIDFILE

