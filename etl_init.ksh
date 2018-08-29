#!/usr/bin/env ksh
set +x
umask 137
#
###########################################################################################
#
# Program: etl_init.ksh
# Date:    05 Feb 2016 script written
# Author:  J.Turck
#
# Purpose: This script is used to init the environment for executing the etl scripts.
#          It can be executed by either id: app_etl or dm_admin.
###########################################################################################

export ETL_RUN=${WOSB_HOME}/etl/etl_run
export ETL_SLOG=${WOSB_HOME}/etl/etl_slog
export ETL_ELOG=${WOSB_HOME}/etl/etl_elog

export ETL_DATA=${DATA_HOME}/etl/etl_data
export ETL_DOCS=${DATA_HOME}/etl/etl_docs
export WOSB_DOCS=${DATA_HOME}/wosb/wosb_docs
export SCHEMA=wosb

export DTS=`date '+%Y%m%d_%H%M%S'`

# Set up a required environment variable.
export PWD_VALUE=`echo ${PWD} | awk -F"/" '{print $5}'`

if [ $PWD_VALUE = "dev" ]; then
  echo 'This is dev.'
  export DATABASE=data_migration_dev
  export PORT=5432
  export HOST=sbaonedev.cypwvkg7qp3n.us-east-1.rds.amazonaws.com
  export S3_BUCKET=sba-docs-dev
fi

if [ $PWD_VALUE = "qa" ]; then
  echo 'This is QA.'
  export DATABASE=data_migration_qa
  export PORT=5432
  #export HOST=sbaonedev.cypwvkg7qp3n.us-east-1.rds.amazonaws.com
  export HOST=db.qa.sba-one.net
  export S3_BUCKET=sba-docs-qa
fi

# This needs modification
if [ $PWD_VALUE = "prod" ]; then
  echo 'This is Production.'
  export DATABASE=data_migration_prod
  export PORT=5432
  #export HOST=sbaoneprod.cyy8xym5djtg.us-east-1.rds.amazonaws.com
  export HOST=db1.certify.sba.gov
  export S3_BUCKET=sba-docs-prod
fi


# Set up sub directories that are not part of the GitHub repository.

if [[ ! -d etl_elog ]]; then
   mkdir -m 776 etl_elog
fi

if [[ ! -d etl_slog ]]; then
   mkdir -m 776 etl_slog
fi

if [[ ! -d ${DATA_HOME}/etl/etl_docs ]]; then
   mkdir -m 776 ${DATA_HOME}/etl/etl_docs
fi

# 
