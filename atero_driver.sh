#!/bin/bash
set +x
#umask 137
###########################################################################################
#
# Program: atero_driver.sh
# Date:    1/29/2018
# Author:  J.Turck
# User:
#
# Purpose: Execute the loading and updating of the Atero database.
#
###########################################################################################
source ${HOME}/config/init.cfg
export PGM_NAME=atero_driver

echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${LOGDIR}/${PGM_NAME}.out
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}.err

###########################################################################################

# Execute incremental export
${HOME}/scripts/data-team/incremental-export.sh

# Remove zero byte files
cd ${HOME}/export/bap; find . -type f -size 0M -name products.csv -exec dirname {} \; | xargs rm -rf

# Execute ingestion script DEMO
. ${HOME}/scripts/data-team/ingestion.sh DEMO

# Execute ingestion script PRD
. ${HOME}/scripts/data-team/ingestion.sh PRD

# Execute QA script
. ${HOME}/scripts/data-team/qa.sh PRD

# Execute s3 sync script
. ${HOME}/scripts/data-team/sync-export.sh PRD

# Execute archive export script
. ${HOME}/scripts/data-team/arc_products_file.sh

exit 0



