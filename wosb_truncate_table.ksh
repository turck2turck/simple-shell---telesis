#!/usr/bin/env ksh
set +x
umask 137
###########################################################################################
#
# Program: wosb_truncate_table.ksh
# Date:    28 December 2015 script written
# Author:  J.Turck
#
# Purpose: This script is used to truncate a table in the WOSB schema.
# 
###########################################################################################


#-----------------------------------------------
#  Main:
#-----------------------------------------------

export TABLE=$1
export USER=dm_admin


. ${WOSB_HOME}/wosb/wosb_init.ksh

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

echo "TRUNCATE TABLE wosb.${TABLE};" > ${WOSB_RUN}/wosb_truncate_${TABLE}.sql 

psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${WOSB_RUN}/wosb_truncate_${TABLE}.sql > ${WOSB_SLOG}/wosb_truncate_${TABLE}.out.${DTS} 2> ${WOSB_ELOG}/wosb_truncate_${TABLE}.out.${DTS}

exit 0

