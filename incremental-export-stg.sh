#!/bin/bash
PIM_ROOT=${HOME}/akeneo/pim-community-standard
EPN_CONFIG=${HOME}/akeneo-package/epn.cfg
source $EPN_CONFIG
export EPN_MFG_ID EPN_CHNL_LIST EPN_DOMAIN PIM_ROOT EPN_CONFIG
PIDFILE=${HOME}/pids/export.pid

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
      echo "Could not create export PID file"
      exit 1
    fi
  fi
else
  echo $$ > $PIDFILE
  if [ $? -ne 0 ]
  then
    echo "Could not create export PID file"
    exit 1
  fi
fi

#echo "${EPN_MFG_ID}"
#IFS=','; for i in ${EPN_CHNL_LIST}
#do
#  CHNL_CODE=$(echo "$i" | xargs | tr ' &./-' _ | tr '[:upper:]' '[:lower:]')
echo "incremental export job start bap:staging_catalog_epurchasingnetwork_com: $('date')"
logger -t akeneo "incremental export job start staging_catalog_epurchasingnetwork_com"

${PIM_ROOT}/app/console akeneo:batch:job -c "{\"filters\":{\"data\":{\"0\":{\"field\":\"family.code\",\"operator\":\"IN\",\"value\":{\"0\":\"epn\"}},\"1\":{\"field\":\"enabled\",\"operator\":\"ALL\",\"value\":\"\"},\"2\":{\"field\":\"completeness\",\"operator\":\"GREATER OR EQUALS THAN ON ALL LOCALES\",\"value\":\"100\",\"context\":{\"locales\":{\"0\":\"en_US\"}}},\"3\":{\"field\":\"updated\",\"operator\":\"SINCE LAST JOB\",\"value\":\"epn_incremental_product_export_staging_catalog_epurchasingnetwork_com\"},\"4\":{\"field\":\"categories.code\",\"operator\":\"IN CHILDREN\",\"value\":{\"0\":\"stage\"}}},\"jobCode\":\"epn_incremental_product_export_staging_catalog_epurchasingnetwork_com\",\"structure\":{\"scope\":\"staging_catalog_epurchasingnetwork_com_channel\",\"locales\":{\"0\":\"en_US\"}}},\"filePath\":\"${HOME}/export/bap/staging_catalog_epurchasingnetwork_com/export_`date +\%s`/products.csv\"}" epn_incremental_product_export_staging_catalog_epurchasingnetwork_com --env=prod > ${HOME}/akeneo/pim-community-standard/app/logs/epn_incremental_product_export_staging_catalog_epurchasingnetwork_com 2>&1
        echo "incremental export job finish bap:staging_catalog_epurchasingnetwork_com: $('date')"
        logger -t akeneo "incremental export job finish staging_catalog_epurchasingnetwork_com"
#done

rm $PIDFILE
