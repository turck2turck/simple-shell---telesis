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
   echo "Please pass in the table you are loading. "
   echo ""

   exit 1
}

#-----------------------------------------------
#  Main:
#-----------------------------------------------

if [[ $# -ne 1 ]]; then
   f_usage
fi

export TABLE=$1
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


if [[ ${TABLE} = "DOCTBL" ]]; then
   export DEL='>'
   . ${WOSB_HOME}/wosb/wosb_data.ksh > ${WOSB_SLOG}/wosb_data_delta.out 2>&1
   es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Exiting. The wosb_data_delta.ksh script with DOCTBL failed with a non-zero exit status = ${es} `date`. "  > ${WOSB_ELOG}/wosb_docs_delta.out
      exit 2
   fi
else
   export DEL='|'
   . ${WOSB_HOME}/wosb/wosb_data_delta.ksh > ${WOSB_SLOG}/wosb_data_delta.out 2>&1
   es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Exiting. The wosb_data_delta.ksh script failed with a non-zero exit status = ${es} `date`. " > ${WOSB_ELOG}/wosb_data_delta.out
      exit 2
   fi
fi

psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${WOSB_RUN}/wosb_record_count.sql >> ${WOSB_SLOG}/wosb_record_count_delta.out.${DTS} 2> ${WOSB_ELOG}/wosb_record_count_delta.out.${DTS}
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the wosb_record_count_delta.sql script."
      exit 3
   fi


exit 0

