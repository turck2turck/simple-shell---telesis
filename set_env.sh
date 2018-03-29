#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: set_env.sh
# Date:    2/9/2018
# Author:  J.Turck
# User:
#
# Purpose: Set environment for DEV,STG, or PRD
#
###########################################################################################
export RUN_ENV=$1
export HOME=/home/ubuntu/
export CONFIG=${HOME}/config

run_env=$1

if [[ ${run_env} == DEV ]]; then
   cp ${CONFIG}/init_dev.cfg ${CONFIG}/init.cfg
   cp ${HOME}/.pwd ${HOME}/.pwx
   cat ${CONFIG}/init.cfg
   exit 0
fi

if [[ ${run_env} == STG ]]; then
   cp ${CONFIG}/init_stg.cfg ${CONFIG}/init.cfg
   cp ${HOME}/.pws ${HOME}/.pwx
   cat ${CONFIG}/init.cfg
   exit 0
fi

if [[ ${RUN_ENV} == PRD ]]; then
   cp ${CONFIG}/init_prd.cfg ${CONFIG}/init.cfg
   cp ${HOME}/.pwp ${HOME}/.pwx
   cat ${CONFIG}/init.cfg
   exit 0
fi

if [[ ${RUN_ENV} == DEMO ]]; then
   cp ${CONFIG}/init_demo.cfg ${CONFIG}/init.cfg
   cp ${HOME}/.pwo ${HOME}/.pwx
   cat ${CONFIG}/init.cfg
   exit 0
fi

