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
source /home/ubuntu/config/init.cfg
export PGM_NAME=atero_driver

echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${LOGDIR}/${PGM_NAME}.out
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}.err

###########################################################################################

# Execute incremental export
/home/ubuntu/akeneo-package/script/incremental-export.sh

# Remove zero byte files
cd /home/ubuntu/export/bap; find . -type f -size 0M -name products.csv -exec dirname {} \; | xargs rm -rf

# Execute ingestion script DEMO
. /home/ubuntu/scripts/data-team/ingestion.sh DEMO

# Execute ingestion script STG
. /home/ubuntu/scripts/data-team/ingestion.sh STG

# Execute ingestion script PRD
. /home/ubuntu/scripts/data-team/ingestion.sh PRD

# Execute QA script
. /home/ubuntu/scripts/data-team/qa.sh PRD

# Execute s3 sync script
. /home/ubuntu/akeneo-package/script/sync-export.sh

# Execute archive export script
. /home/ubuntu/scripts/data-team/arc_products_file.sh

exit 0



