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

run_env=$1

if [[ ${run_env} == DEV ]]; then
   cp init_dev.cfg init.cfg
   cp ${HOME}/.pwd ${HOME}/.pwx
   cat init.cfg
   exit 0
fi

if [[ ${run_env} == STG ]]; then
   cp init_stg.cfg init.cfg
   cp ${HOME}/.pws ${HOME}/.pwx
   cat init.cfg
   exit 0
fi

if [[ ${RUN_ENV} == PRD ]]; then
   cp init_prd.cfg init.cfg
   cp ${HOME}/.pwp ${HOME}/.pwx
   cat init.cfg
   exit 0
fi

if [[ ${RUN_ENV} == DEMO ]]; then
   cp init_demo.cfg init.cfg
   cp ${HOME}/.pwo ${HOME}/.pwx
   cat init.cfg
   exit 0
fi

