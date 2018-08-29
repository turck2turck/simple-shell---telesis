#!/usr/bin/env ksh
set +x
umask 137
###########################################################################################
#
# Program: wosb_docs.ksh
# Date:    07 January 2016 script written
# Author:  J.Turck
#
# Purpose: Process wosb documents brought infrom SBA Oracle ORAWEBP1 through S3 buckets.
#          Execute the script and pass in the FILE as $1
# 
# User: app_etl
#
#
###########################################################################################

echo "The wosb_docs.ksh script started at: ${DTS}" > ${WOSB_SLOG}/wosb_docs_run_time.out
#-----------------------------------------------
#  Main:
#-----------------------------------------------
if [[ $# -ne 2 ]]; then
  echo "You must pass in a table name (in capitals) to process. "
fi

echo "the table parm in wosb_data is: ${TABLE}"
echo "The delimiter is: ${DEL}"

#-----------------------------------------------------------------------------
# Copy the data from S3 to UNIX for processing. Then move the table for the next
# file to be processed.
#-----------------------------------------------------------------------------

#aws s3 ls s3://${S3_BUCKET}/WOSB_DOCS/ |grep export.ldr.7z |awk '{print $4}'> ${WOSB_DOCS}/s3.txt
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the s3 ls command."
      exit 3
   fi

cd ${WOSB_DOCS}

#cat s3.txt |while read i 
#do
##   aws s3 cp s3://${S3_BUCKET}/WOSB_DOCS/${i} ${WOSB_DOCS}/
###done

#7za e export.ldr.7z.001 -p${ZIP_PASS}

es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with 7 unzip command."
      exit 3
   fi

#if [[ ${RUN_TYPE} = DELTA ]]; then
   #echo "Running the DELTA extract file."
   #cp table_export_DATA.ldr ${TABLE}.txt
#fi
#if [[ ${RUN_TYPE} = MAIN ]]; then
   #echo "Running the MAIN extract file."
   #cp DOCFILEUPLOADTBL_DATA_TABLE.ldr ${TABLE}.txt
#fi

es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with copy table command."
      exit 3
   fi


#-----------------------------------------------------------------------------
# Process the data removing the "s and final '|' .
#-----------------------------------------------------------------------------

cat ${WOSB_DOCS}/${TABLE}.txt |sed 's/"//g' |sed 's/.$//' > ${WOSB_DOCS}/${TABLE}_run.txt

#-----------------------------------------------------------------------------
# Build copy sql command
#-----------------------------------------------------------------------------

echo " \COPY wosb.${TABLE} FROM ${WOSB_DOCS}/${TABLE}_run.txt WITH DELIMITER AS ${DEL} NULL as '' " > ${WOSB_RUN}/insert_${TABLE}.sql
echo " SELECT COUNT(*) FROM wosb.${TABLE} " > ${WOSB_RUN}/count_${TABLE}.sql

#-----------------------------------------------------------------------------
# Update the database
#-----------------------------------------------------------------------------

psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${WOSB_RUN}/insert_${TABLE}.sql > ${WOSB_SLOG}/insert_${TABLE}.out.${DTS} 2> ${WOSB_ELOG}/insert_${TABLE}.out.${DTS}

es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the insert SQL command."
      exit 3
   fi

psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${WOSB_RUN}/count_${TABLE}.sql > ${WOSB_SLOG}/count_${TABLE}.out.${DTS} 2> ${WOSB_ELOG}/count_${TABLE}.out.${DTS}

es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the count SQL command."
      exit 3
   fi
cat ${WOSB_DOCS}/s3.txt |while read i 
do
   aws s3 mv s3://${S3_BUCKET}/WOSB_DOCS/${i} s3://${S3_BUCKET}/WOSB_ARCHIVE/WOSB_DOCS/${SCHEMA}.${i}.${DTS}
done

es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the move SQL command."
      exit 3
   fi

cd ${WOSB_DOCS}
ls |wc -l >> ${WOSB_SLOG}/count_downloaded_docs.out.${DTS}
aws s3 mv ${WOSB_SLOG}/* s3://${S3_BUCKET}/WOSB_ARCHIVE/WOSB_DOCS/


echo "The wosb_docs.ksh script ended at: ${DTS}" >> ${WOSB_SLOG}/wosb_docs_run_time.out
exit 0

