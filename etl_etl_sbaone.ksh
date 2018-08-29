#!/usr/bin/env ksh
set +x
umask 137
############################################################################################
#
# Program: etl_etl_sbaone.ksh
# Date:    08 February 2016 script written
# Author:  J.Turck
#
# Purpose: This script is used to extract data from the etl schema and load the data to the 
#          sbaone schema. 
#
# User: app_etl
# 
###########################################################################################


#-----------------------------------------------
#  Main:
#-----------------------------------------------


#-----------------------------------------------------------------------------
# Extract data from the ETL schema 
#-----------------------------------------------------------------------------

echo " \COPY etl.documents to '${ETL_DATA}/documents.txt' WITH DELIMITER AS '|' NULL as ''" > ${ETL_RUN}/extract_documents.sql
echo " \COPY etl.organizations to '${ETL_DATA}/organizations.txt' WITH DELIMITER AS '|' NULL as ''" > ${ETL_RUN}/extract_organizations.sql

psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${ETL_RUN}/extract_documents.sql > ${ETL_SLOG}/extract_documents.out.${DTS} 2> ${ETL_ELOG}/extract_documents.out.${DTS}
psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${ETL_RUN}/extract_organizations.sql > ${ETL_SLOG}/extract_organizations.out.${DTS} 2> ${ETL_ELOG}/extract_organizations.out.${DTS}

#-----------------------------------------------------------------------------
# Insert the extracted data into the SBAONE schema
#-----------------------------------------------------------------------------

if [[ $PWD_VALUE = "dev" ]]; then
  export DATABASE=sbaone_dev
  export PORT=5432
  export HOST=sbaonedev.cypwvkg7qp3n.us-east-1.rds.amazonaws.com
fi
if [[ $PWD_VALUE = "qa" ]]; then
  export DATABASE=sbaone_qa
  export PORT=5432
  export HOST=sbaonedev.cypwvkg7qp3n.us-east-1.rds.amazonaws.com
fi
if [[ $PWD_VALUE = "prod" ]]; then
  export DATABASE=sbaone_prod
  export PORT=5432
 # export HOST=sbaoneprod.cyy8xym5djtg.us-east-1.rds.amazonaws.com
  export HOST=db1.certify.sba.gov
fi


echo " \COPY sbaone.organizations FROM '${ETL_DATA}/organizations.txt' WITH DELIMITER AS '|' NULL as ''" > ${ETL_RUN}/upload_organizations.sql
echo " \COPY sbaone.documents FROM '${ETL_DATA}/documents.txt' WITH DELIMITER AS '|' NULL as ''" > ${ETL_RUN}/upload_documents.sql

echo " SELECT COUNT(*) FROM sbaone.organizations " > ${ETL_RUN}/count_organizations.sql
echo " SELECT COUNT(*) FROM sbaone.documents " > ${ETL_RUN}/count_documents.sql

psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${ETL_RUN}/upload_organizations.sql > ${ETL_SLOG}/upload_organizations.out.${DTS} 2> ${ETL_ELOG}/upload_organizations.out.${DTS}
psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${ETL_RUN}/count_organizations.sql > ${ETL_SLOG}/count_organizations.out.${DTS} 2> ${ETL_ELOG}/count_organizations.out.${DTS}
psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${ETL_RUN}/upload_documents.sql > ${ETL_SLOG}/upload_documents.out.${DTS} 2> ${ETL_ELOG}/upload_documents.out.${DTS}
psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${ETL_RUN}/count_documents.sql > ${ETL_SLOG}/count_documents.out.${DTS} 2> ${ETL_ELOG}/count_documents.out.${DTS}

