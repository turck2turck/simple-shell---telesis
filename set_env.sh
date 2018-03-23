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
<<<<<<< HEAD
###########################################################################################
export RUN_ENV=$1
export HOME=/home/ubuntu/
=======
###########################################################################################A

run_env=$1

echo ${run_env} 
>>>>>>> 2bf7a72d38b355222031dbbc9e93e7587d0ab957

if [[ ${run_env} == DEV ]]; then
   cp init_dev.cfg init.cfg
<<<<<<< HEAD
   cp ${HOME}/.pwd ${HOME}/.pwx
=======
   cp ${HOME}/.pwd ${HOME}.pwx
   cat init.cfg
   exit 0
>>>>>>> 2bf7a72d38b355222031dbbc9e93e7587d0ab957
fi

if [[ ${run_env} == STG ]]; then
   cp init_stg.cfg init.cfg
<<<<<<< HEAD
   cp ${HOME}/.pws ${HOME}/.pwx
fi

if [[ ${RUN_ENV} == PRD ]]; then
   cp init_prd.cfg init.cfg
   cp ${HOME}/.pwp ${HOME}/.pwx
fi

if [[ ${RUN_ENV} == DEMO ]]; then
   cp init_demo.cfg init.cfg
   cp ${HOME}/.pwo ${HOME}/.pwx
=======
   cp ${HOME}/.pws ${HOME}.pwx
   cat init.cfg
   exit 0
>>>>>>> 2bf7a72d38b355222031dbbc9e93e7587d0ab957
fi

if [[ ${run_env} == PRD ]]; then
   cp init_prd.cfg init.cfg
   cp ${HOME}/.pwp ${HOME}.pwx
   cat init.cfg
   exit 0
fi

if [[ ${run_env} == DEMO ]]; then
   cp init_demo.cfg init.cfg
   cp ${HOME}/.pwo ${HOME}.pwx
   cat init.cfg
   exit 0
fi
