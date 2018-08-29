#!/usr/bin/env ksh
set +x
umask 137
############################################################################################
#
# Program: wosb_init.ksh
# Date:    05 Feb 2016 script written
# Author:  J.Turck
#
# Purpose: This script is used to init the environment for executing the wosb scripts.
#          It can be executed by either id: app_wosb or dm_admin.
###########################################################################################

export WOSB_RUN=${WOSB_HOME}/wosb/wosb_run
export WOSB_SLOG=${WOSB_HOME}/wosb/wosb_slog
export WOSB_ELOG=${WOSB_HOME}/wosb/wosb_elog

export WOSB_DATA=${DATA_HOME}/wosb/wosb_data
export WOSB_DOCS=${DATA_HOME}/wosb/wosb_docs
export WOSB_DATA_DELTA=${DATA_HOME}/wosb/wosb_data_delta
export WOSB_DOCS_DELTA=${DATA_HOME}/wosb/wosb_docs_delta

export SCHEMA=wosb

export DTS=`date '+%Y%m%d_%H%M%S'`

# Set up a required environment variable.
export PWD_VALUE=`echo ${PWD} | awk -F"/" '{print $5}'`

if [ $PWD_VALUE = "dev" ]; then
  echo 'This is dev.'
  export DATABASE=data_migration_dev
  export S3_BUCKET=dev-dm-staging
  export HOST=sbaonedev.cypwvkg7qp3n.us-east-1.rds.amazonaws.com
  export PORT=5432
fi

if [ $PWD_VALUE = "qa" ]; then
  echo 'This is QA.'
  export DATABASE=data_migration_qa
  export S3_BUCKET=qa-dm-staging
  #export HOST=sbaonedev.cypwvkg7qp3n.us-east-1.rds.amazonaws.com
  export HOST=db.qa.sba-one.net
  export PORT=5432
fi

if [ $PWD_VALUE = "prod" ]; then
  echo 'This is Production.'
  export DATABASE=data_migration_prod
  export PORT=5432
  #export HOST=sbaoneprod.cyy8xym5djtg.us-east-1.rds.amazonaws.com
  export HOST=db1.certify.sba.gov
  export S3_BUCKET=dm-staging-prod
fi




# Set up sub directories that are not part of the GitHub repository.

if [[ ! -d wosb_elog ]]; then
   mkdir -m 776 wosb_elog
fi

if [[ ! -d wosb_slog ]]; then
   mkdir -m 776 wosb_slog
fi


if [[ ! -d ${DATA_HOME}/wosb/wosb_docs ]]; then
   mkdir -m 776 ${DATA_HOME}/wosb/wosb_docs
fi

if [[ ! -d ${DATA_HOME}/wosb/wosb_data ]]; then
   mkdir -m 776 ${DATA_HOME}/wosb/wosb_data
fi

if [[ ! -d ${DATA_HOME}/wosb/wosb_docs_delta ]]; then
   mkdir -m 776 ${DATA_HOME}/wosb/wosb_docs_delta
fi

if [[ ! -d ${DATA_HOME}/wosb/wosb_data_delta ]]; then
   mkdir -m 776 ${DATA_HOME}/wosb/wosb_data_delta
fi

