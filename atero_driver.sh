#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: atero_driver.sh
# Date:    1/29/2018
# Author:  J.Turck
# User:
#
# Purpose: Execute the loading and updateing of the Atero database.
#
###########################################################################################
source /home/ubuntu/config/init.cfg
PIDFILE=/home/ubuntu/atero_driver.pid

#-----------------------------------------------
#  Main:
#-----------------------------------------------
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

if [[ -f ${LOGDIR}/upsert_product.out ]]; then
   mv ${LOGDIR}/upsert_product.out ${LOGDIR}/upsert_product.${DTS}
fi

echo "Insert and Update public.product on ${DTS} " > ${LOGDIR}/atero_driver.out
echo "Insert and Update ERRORS for public.product on ${DTS} " > ${ELOGDIR}/atero_driver.err
echo "HOST is: ${HOST}" >> ${LOGDIR}/atero_driver.out
echo "USER is: ${USER}" >> ${LOGDIR}/atero_driver.out
echo "Database is ${DATABASE}" >> ${LOGDIR}/atero_driver.out

if [ -f $PIDFILE ]
then
  PID=$(cat $PIDFILE)
  ps -p $PID > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    echo "Atero process already running"
    exit 1
  else
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


./${RUNDIR}/upsert_product.sh
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the upsert_product.sh script."
      exit 3
   else
      echo "Upsert process completed successfully." >> ${LOGDIR}/atero_driver.out
      mv ${DATADIR}/products.csv ${ARCHDIR}/products.${DTS}
   fi


exit 0
