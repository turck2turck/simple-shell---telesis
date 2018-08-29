#!/usr/bin/env ksh
set +x
umask 137
###########################################################################################
#
# Program: wosb_data.ksh
# Date:    28 December 2015 script written
# Author:  J.Turck
#
# Purpose: This script is used to load wosb extracted data to the wosb schema in postgresql.
#          The unloaded data should be stored in the ${S3_BUCKET}/WOSB_DATA directory with 
#          a file name of ${TABLE}.zip. 
#          This script is used to process and load all WOSB data with the exception of the 
#          DOCFILEUPLOADTBL. This table holds the actual documents (BLOB DATA). Use the script
#          wosb_docs.ksh to process the documents. 
#          At the completion of this script the original .zip file will be renamed with a 
#          datetime stamp and the processed data and standard logs will be copied to the 
#          Staging bucket under ARCHIVE/WOSB_DATA.
#
# User: app_etl
# 
###########################################################################################


#-----------------------------------------------
#  Main:
#-----------------------------------------------

if [[ $# -ne 1 ]]; then
  echo "You must pass in a table name (in capitals) to process. " 
fi

echo "the table parm in wosb_data is: ${TABLE}"
echo "The delimiter is: ${DEL}"

#-----------------------------------------------------------------------------
# Copy the data from S3 to UNIX for processing. Then move the table for the next
# file to be processed.
#-----------------------------------------------------------------------------

#aws s3 cp s3://${S3_BUCKET}/WOSB_DATA/${TABLE}.zip ${WOSB_DATA}/${TABLE}.zip

es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with s3 copy command."
      exit 3
   fi

cd ${WOSB_DATA}/
#unzip ${TABLE}.zip 

es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with unzip command."
      exit 3
   fi

#-----------------------------------------------------------------------------
# Cleanse the data
#-----------------------------------------------------------------------------
cat ${WOSB_DATA}/${TABLE}.txt |sed 's/"//g' |sed 's/.$//' > ${WOSB_DATA}/${TABLE}_run.txt

#-----------------------------------------------------------------------------
# Build copy sql command
#-----------------------------------------------------------------------------

echo " \COPY wosb.${TABLE} FROM '${WOSB_DATA}/${TABLE}_run.txt' WITH DELIMITER AS '${DEL}' NULL as '' " > ${WOSB_RUN}/insert_${TABLE}.sql
echo " SELECT COUNT(*) FROM wosb.${TABLE} " > ${WOSB_RUN}/count_${TABLE}.sql

#-----------------------------------------------------------------------------
#  Load the data 
#-----------------------------------------------------------------------------

psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${WOSB_RUN}/insert_${TABLE}.sql > ${WOSB_SLOG}/insert_${TABLE}.out.${DTS} 2> ${WOSB_ELOG}/insert_${TABLE}.out.${DTS}
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the insert SQL command."
      exit 3
   fi

psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${WOSB_RUN}/count_${TABLE}.sql >> ${WOSB_SLOG}/count_${TABLE}.out.${DTS} 2> ${WOSB_ELOG}/count_${TABLE}.out.${DTS}
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the count SQL command."
      exit 3
   fi



## Copy data file back to S3 Staging under an archive Folder and move the logs to the same.

aws s3 mv ${WOSB_DATA}/${TABLE}.zip s3://${S3_BUCKET}/WOSB_ARCHIVE/WOSB_DATA/${SCHEMA}.downloaded.${TABLE}.zip.${DTS}
aws s3 cp ${WOSB_SLOG}/insert_${TABLE}.out.${DTS} s3://${S3_BUCKET}/WOSB_ARCHIVE/WOSB_DATA/${SCHEMA}.insert_${TABLE}.out.${DTS}
aws s3 cp ${WOSB_SLOG}/count_${TABLE}.out.${DTS} s3://${S3_BUCKET}/WOSB_ARCHIVE/WOSB_DATA/${SCHEMA}.count_${TABLE}.out.${DTS}
aws s3 mv s3://${S3_BUCKET}/WOSB_DATA/${TABLE}.zip s3://${S3_BUCKET}/WOSB_ARCHIVE/WOSB_DATA/${SCHEMA}.${TABLE}.zip.${DTS}

es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with one of the S3 copy or move commands."
      exit 3
   fi

exit 0

