#!/usr/bin/env ksh
set +x
umask 137
###########################################################################################
#
# Program: etl_truncate.ksh
# Date:    28 December 2015 script written
# Author:  J.Turck
#
# Purpose: This script is used to truncate tables in the ETL schema.
#
# User: dm_admin
# 
###########################################################################################



#-----------------------------------------------
#  Main:
#-----------------------------------------------

. ${WOSB_HOME}/etl/etl_init.ksh

export TABLE=$1

export USER=dm_admin

if [[ -s ${HOME}/.pwd ]]; then
   . ${HOME}/.pwd
else
   echo ""
   echo ""
   echo "ERROR: password file ${HOME}/.pwd is empty or does not exist"
   echo "       processing terminating now."
   echo ""
   echo ""
   exit 99
fi

echo "TRUNCATE TABLE etl.${TABLE};" > ${ETL_RUN}/etl_truncate_${TABLE}.sql 

psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${ETL_RUN}/etl_truncate_${TABLE}.sql > ${ETL_SLOG}/etl_truncate_${TABLE}.out.${DTS} 2> ${ETL_ELOG}/etl_truncate_${TABLE}.out.${DTS}

exit 0

