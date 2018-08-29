#!/usr/bin/env ksh
set +x
umask 137
###########################################################################################
#
# Program: etl_driver.ksh
# Date:    February 16, 2016 script written
# Author:  J.Turck
#
# Purpose: This script is used as a wrapper to execute the etl_data script and the 
#          etl_etl_sbaone script.
#
# User: app_etl
# 
###########################################################################################

f_usage()
{
   echo ""
   echo "Please pass in the table you are loading to as $1."
   echo ""

   exit 1
}
########################################################################
# Main
########################################################################

if [[ $# -ne 1 ]]; then
   f_usage
fi



. ${WOSB_HOME}/etl/etl_init.ksh

export USER=app_etl
export PULL_DATE=$1

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

# Execute the etl_data script.

#. ${WOSB_HOME}/etl/etl_data.ksh > ${ETL_SLOG}/etl_data.out 2>&1
es=${?}
if [[ ${es} -ne 0 ]]; then
   echo "Exiting. The etl_data script failed with a non-zero exit status = ${es} `date`. " > ${ETL_ELOG}/etl_data.out.${DTS}
   exit 2
fi

# Execute the etl_etl_sbaone script.

. ${WOSB_HOME}/etl/etl_etl_sbaone.ksh > ${ETL_SLOG}/etl_etl_sbaone.out 2>&1
es=${?}
if [[ ${es} -ne 0 ]]; then
   echo "Exiting. The etl_etl_sbaone script failed with a non-zero exit status = ${es} `date`. " > ${ETL_ELOG}/etl_etl_sbaone.out.${DTS}
   exit 2
else
   exit 0
fi

