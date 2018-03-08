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

if [[ ${RUN_ENV} == DEV ]]; then
   cp init_dev.cfg init.cfg
fi

if [[ ${RUN_ENV} == STG ]]; then
   cp init_stg.cfg init.cfg
fi

echo "The Environment is: "
cat init.cfg
