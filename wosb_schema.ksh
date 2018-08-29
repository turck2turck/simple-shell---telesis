#!/usr/bin/env ksh
set +x
umask 137
###########################################################################################
#
# Program: wosb_schema.ksh
# Date:    28 December 2015 script written
# Author:  J.Turck
#
# Purpose: This script is used to drop and re-build the WOSB schema.
# 
# User: dm_admin
#
###########################################################################################



#-----------------------------------------------
#  Main:
#-----------------------------------------------

. ${WOSB_HOME}/wosb/wosb_init.ksh

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


psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${WOSB_RUN}/wosb_delta_DDL.sql > ${WOSB_SLOG}/wosb_DDL.out.${DTS} 2> ${WOSB_ELOG}/wosb_DDL.out.${DTS}
#psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${WOSB_RUN}/wosb_DDL.sql > ${WOSB_SLOG}/wosb_DDL.out.${DTS} 2> ${WOSB_ELOG}/wosb_DDL.out.${DTS}

exit 0

