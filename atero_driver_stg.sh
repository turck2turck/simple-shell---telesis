#!/bin/bash
set +x
#umask 137
###########################################################################################
#
# Program: atero_driver_stg.sh
# Date:    1/29/2018
# Author:  J.Turck
# User:
#
# Purpose: Execute the loading and updating of the Atero database.
#
###########################################################################################
cp /home/ubuntu/config/init_stg.cfg /home/ubuntu/config/init.cfg
source /home/ubuntu/config/init.cfg
export PGM_NAME=atero_driver_stg

echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${LOGDIR}/${PGM_NAME}.out
echo "Executing ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}.err

###########################################################################################

# Execute incremental export
/home/ubuntu/scripts/data-team/incremental-export-stg.sh

# Remove zero byte files
cd /home/ubuntu/export/bap; find . -type f -size 0M -name products.csv -exec dirname {} \; | xargs rm -rf


# Execute ingestion script DEV
. /home/ubuntu/scripts/data-team/ingestion.sh STG

# Execute s3 sync script
. /home/ubuntu/scripts/data-team/sync-export.sh STG

# Execute products.csv Archive
. /home/ubuntu/scripts/data-team/arc_products_file.sh

exit 0



