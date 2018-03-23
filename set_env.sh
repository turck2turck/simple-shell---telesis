#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: set_env.sh
# Date:    3/8/2018
# Author:  J.Turck
# User:
#
# Purpose: Set up the corrent environment variables.
#
###########################################################################################
export RUN_ENV=$1
export HOME=/home/ubuntu/

if [[ ${RUN_ENV} == DEV ]]; then
   cp init_dev.cfg init.cfg
   cp ${HOME}/.pwd ${HOME}/.pwx
fi

if [[ ${RUN_ENV} == STG ]]; then
   cp init_stg.cfg init.cfg
   cp ${HOME}/.pws ${HOME}/.pwx
fi

if [[ ${RUN_ENV} == PRD ]]; then
   cp init_prd.cfg init.cfg
   cp ${HOME}/.pwp ${HOME}/.pwx
fi

if [[ ${RUN_ENV} == DEMO ]]; then
   cp init_demo.cfg init.cfg
   cp ${HOME}/.pwo ${HOME}/.pwx
fi

echo "The Environment is: "
cat init.cfg
