#!/usr/bin/env ksh
set +x
umask 137
###########################################################################################
#
# Program: wosb_data_delta.ksh
# Date:    11 March 2016 script written
# Author:  J.Turck
#
# Purpose: This script is used to load the wosb delta records.
#
# User: app_etl
#
###########################################################################################

#-----------------------------------------------
#  Main:
#-----------------------------------------------
if [[ $# -ne 1 ]]; then
  echo "You must pass in a table name in capitals to process. "
fi

echo "the table parm in wosb_data is: ${TABLE}"

echo "The delimiter is: ${DEL}"

#-----------------------------------------------------------------------------
# Copy the data from S3 to UNIX for processing. Then move the table for the next
# file to be processed.
#-----------------------------------------------------------------------------

aws s3 cp s3://${S3_BUCKET}/WOSB_DATA_DELTA/${TABLE}.zip ${WOSB_DATA_DELTA}/${TABLE}.zip
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with s3 copy command."
      exit 3
   fi

cd ${WOSB_DATA_DELTA}/
unzip ${TABLE}.zip
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with unzip command."
      exit 3
   fi

#-----------------------------------------------------------------------------
# Cleanse the data
#-----------------------------------------------------------------------------
cat ${WOSB_DATA_DELTA}/${TABLE}.txt |sed 's/"//g' |sed 's/.$//'  > ${WOSB_DATA_DELTA}/${TABLE}_run.txt

if [[ ${TABLE} = "DOCTBL" ]]; then
 cat ${WOSB_DATA_DELTA}/${TABLE}_run.txt |awk -F"|" '{print "delete from ${SCHEMA}.${TABLE} where docid = "$1";"}' > ${WOSB_RUN}/delete_${TABLE}_delta.sql
fi

if [[ ${TABLE} = "DOCTBL_BKP" ]]; then
 cat ${WOSB_DATA_DELTA}/${TABLE}_run.txt |awk -F"|" '{print "delete from ${SCHEMA}.${TABLE} where docid = "$1";"}'  > ${WOSB_RUN}/delete_${TABLE}_delta.sql
fi

if [[ ${TABLE} = "DOCAUTHTBL" ]]; then
   cat ${WOSB_DATA_DELTA}/${TABLE}_run.txt |awk -F"|" '{print "delete from wosb.docauthtbl where taxid = \""$1"\" and docauthnmb = "$2 " and solctnnmb = \""$3"\";"}' |sed "s/\"/'/g" > ${WOSB_RUN}/delete_${TABLE}_delta.sql
fi

if [[ ${TABLE} = "DOCHSTRYTBL" ]]; then
 cat ${WOSB_DATA_DELTA}/${TABLE}_run.txt |awk -F"|" '{print "delete from ${SCHEMA}.${TABLE} where docid = "$1"and dochstryseqnmb = "$2 ";"}' > ${WOSB_RUN}/delete_${TABLE}_delta.sql
fi

if [[ ${TABLE} = "IMUSERINFOTBL" ]]; then
 cat ${WOSB_DATA_DELTA}/${TABLE}_run.txt |awk -F"|" '{print "delete from ${SCHEMA}.${TABLE} where imusernm =  \""$1"\" and imuserbuseinssnind =  \""$2"\" and imuserbustaxid =  \""$3"\" and imuserbuslocdunsnmb =  \""$4"\";"}'  |sed "s/\"/'/g" > ${WOSB_RUN}/delete_${TABLE}_delta.sql
fi


#-----------------------------------------------------------------------------
# Build copy sql command
#-----------------------------------------------------------------------------

echo " \COPY wosb.${TABLE} FROM '${WOSB_DATA_DELTA}/${TABLE}_run.txt' WITH DELIMITER AS '${DEL}' NULL as '' " > ${WOSB_RUN}/insert_${TABLE}_delta.sql
echo " SELECT COUNT(*) FROM wosb.${TABLE} " > ${WOSB_RUN}/count_${TABLE}_delta.sql

#-----------------------------------------------------------------------------
#  Delete and then load the data
#-----------------------------------------------------------------------------


psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${WOSB_RUN}/delete_${TABLE}_delta.sql > ${WOSB_SLOG}/delete_${TABLE}_delta.out.${DTS} 2> ${WOSB_ELOG}/delete_${TABLE}_delta.out.${DTS}
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the delete table delta SQL command."
      exit 3
   fi

psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${WOSB_RUN}/insert_${TABLE}_delta.sql > ${WOSB_SLOG}/insert_${TABLE}_delta.out.${DTS} 2> ${WOSB_ELOG}/insert_${TABLE}_delta.out.${DTS}

es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the insert table delta SQL command."
      exit 3
   fi


psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${WOSB_RUN}/count_${TABLE}.sql >> ${WOSB_SLOG}/count_${TABLE}_delta.out.${DTS} 2> ${WOSB_ELOG}/count_${TABLE}_delta.out.${DTS}
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the count SQL command."
      exit 3
   fi
## Copy data file back to S3 Staging under an archive Folder and move the logs to the same.

aws s3 mv ${WOSB_DATA}/${TABLE}.zip s3://${S3_BUCKET}/WOSB_ARCHIVE/WOSB_DATA/${SCHEMA}.downloaded.${TABLE}.zip.${DTS}
aws s3 cp ${WOSB_SLOG}/insert_${TABLE}_delta.out.${DTS} s3://${S3_BUCKET}/WOSB_ARCHIVE/WOSB_DATA/${SCHEMA}.insert_${TABLE}_delta.out.${DTS}
aws s3 cp ${WOSB_SLOG}/count_${TABLE}_delta.out.${DTS} s3://${S3_BUCKET}/WOSB_ARCHIVE/WOSB_DATA/${SCHEMA}.count_${TABLE}_delta.out.${DTS}
aws s3 mv s3://${S3_BUCKET}/WOSB_DATA/${TABLE}.zip s3://${S3_BUCKET}/WOSB_ARCHIVE/WOSB_DATA/${SCHEMA}.${TABLE}.zip.${DTS}

es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with one of the S3 copy or move commands."
      exit 3
   fi

exit 0

