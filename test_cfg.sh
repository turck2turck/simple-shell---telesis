#!/bin/bash
set +x
umask 137
export DEALER=$1
source /home/ubuntu/config/init.cfg

cat ${DATADIR}/${DEALER}.txt |dos2unix >${CONFIG}/${DEALER}.cfg
cat ${DATADIR}/${DEALER}_mfr.txt |dos2unix >${CONFIG}/${DEALER}_mfr.cfg


exit 0
