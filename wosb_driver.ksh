#!/usr/bin/env ksh
set +x
umask 137
###########################################################################################
#
# Program: wosb_driver.ksh
# Date:    February 16, 2016 script written
# Author:  J.Turck
#
# Purpose: This script is used as a wrapper to execute the wosb_data script or the 
#          wosb_docs script based on the Table name passed in on the command line.
#
# User: app_etl
# 
###########################################################################################


f_usage()
{
   echo ""
   echo "Please pass in the table you are loading and either MAIN or DELTA."
   echo ""
   
   exit 1
}

#-----------------------------------------------
#  Main:
#-----------------------------------------------

if [[ $# -ne 2 ]]; then
   f_usage
fi

export TABLE=$1
export RUN_TYPE=$2
export DEL='|'
export USER=app_etl

. ${WOSB_HOME}/wosb/wosb_init.ksh

if [[ -s ${HOME}/.pwa ]]; then
   . ${HOME}/.pwa
else
   echo ""
   echo "ERROR: password file ${HOME}/.pwa is empty or does not exist"
   echo "       processing terminating now."
   exit 99
fi

#if [[ ${TABLE} = "DOCFILEUPLOADTBL" ]]; then
if [[ ${TABLE} = "DOCFILEUPLOADTBL_delta" ]]; then
   export DEL='|'
   if [[ -s ${HOME}/.pwz ]]; then
      . ${HOME}/.pwz
   else
      echo ""
      echo "ERROR: password file ${HOME}/.pwa is empty or does not exist"
      echo "       processing terminating now."
      exit 99
   fi
   . ${WOSB_HOME}/wosb/wosb_docs.ksh > ${WOSB_SLOG}/wosb_docs.out 2>&1
   es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Exiting. The wosb_docs script with DOCFILEUPLOADTBL failed with a non-zero exit status = ${es} `date`. "  > ${WOSB_ELOG}/wosb_docs.out
      exit 2
   fi
fi

#if [[ ${TABLE} = "DOCTBL" ]]; then
if [[ ${TABLE} = "DOCTBL_delta" ]]; then
   export DEL='>'
   . ${WOSB_HOME}/wosb/wosb_data.ksh > ${WOSB_SLOG}/wosb_data.out 2>&1
   es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Exiting. The wosb_data script with DOCTBL failed with a non-zero exit status = ${es} `date`. "  > ${WOSB_ELOG}/wosb_data.out
      exit 2
   fi
else
   export DEL='|'
   . ${WOSB_HOME}/wosb/wosb_data.ksh > ${WOSB_SLOG}/wosb_data.out 2>&1
   es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Exiting. The wosb_data script failed with a non-zero exit status = ${es} `date`. " > ${WOSB_ELOG}/wosb_data.out
      exit 2
   fi
fi

psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${WOSB_RUN}/wosb_record_count.sql >> ${WOSB_SLOG}/wosb_record_count.out.${DTS} 2> ${WOSB_ELOG}/wosb_record_count.out.${DTS}
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the wosb_record_count.sql script."
      exit 3
   fi


exit 0

