#!/usr/bin/env ksh
set +x
umask 137
###########################################################################################
#
# Program: etl_data.ksh
# Date:    28 December 2015 script written
# Author:  J.Turck
#
# Purpose: This script is used to extract documents and organizations from the postgresql
#          WOSB schema and add them to the postgresql ETL schema. 
#
# User: app_etl
# 
###########################################################################################


#-----------------------------------------------
#  Main:
#-----------------------------------------------


export TFILE="/tmp/$(basename $0).$$.tmp"

#-----------------------------------------------------------------------------
#  Add data to the etl schema
#-----------------------------------------------------------------------------

#echo " \COPY etl.DOC_TYPE_CROSSWALK FROM '${ETL_RUN}/DOC_TYPE_CROSSWALK.txt' WITH DELIMITER AS '|' NULL as ''" > ${ETL_RUN}/insert_DOC_TYPE_CROSSWALK.sql
#echo " \copy (select r.folder_name, r.docdata, r.docdata_pdf from etl.select_recs r )  to '${ETL_RUN}/extract_folders.out'" > ${ETL_RUN}/extract_folders.sql
#echo "INSERT INTO etl.select_recs ( IMUSERBUSEINSSNIND, IMUSERBUSTAXID, IMUSERBUSLOCDUNSNMB, DOCID, DOCDATA, DOCDATA_PDF, CREATDT, LASTUPDDT, DOCNM, DOCTYPCD) (SELECT CASE WHEN a.IMUSERBUSEINSSNIND ='E' THEN 'EIN' WHEN a.IMUSERBUSEINSSNIND ='S' THEN 'SSN' ELSE 'XXX' END, a.IMUSERBUSTAXID, a.IMUSERBUSLOCDUNSNMB, c.DOCID, c.DOCDATA, trim(c.DOCDATA,'.ldr')||'.pdf', b.CREATDT, b.LASTUPDDT, b.DOCNM, b.DOCTYPCD from (select distinct IMUSERBUSLOCDUNSNMB, IMUSERBUSTAXID, IMUSERBUSEINSSNIND from wosb.IMUSERINFOTBL) a, wosb.DOCTBL b, wosb.DOCFILEUPLOADTBL c where a.IMUSERBUSLOCDUNSNMB = b.DUNS and a.IMUSERBUSTAXID = substr (b.TAXID, 2,9) and b.docid = c.docid and b.DOCACTVINACTIND = 'A' and b.LASTUPDDT >= '${PULL_DATE}' and b.DOCSTATCD IN (4, 5)); " > ${ETL_RUN}/insert_select_recs.sql

#psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${ETL_RUN}/insert_DOC_TYPE_CROSSWALK.sql > ${ETL_SLOG}/insert_DOC_TYPE_CROSSWALK.out.${DTS} 2> ${ETL_ELOG}/insert_DOC_TYPE_CROSSWALK.out.${DTS}
#psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${ETL_RUN}/insert_select_recs.sql > ${ETL_SLOG}/insert_select_recs.out.${DTS} 2> ${ETL_ELOG}/insert_select_recs.out.${DTS}
#psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${ETL_RUN}/update_doctypcd.sql > ${ETL_SLOG}/update_doctypcd.out.${DTS} 2> ${ETL_ELOG}/update_doctypcd.out.${DTS}
#psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${ETL_RUN}/insert_orgs.sql > ${ETL_SLOG}/insert_orgs.out.${DTS} 2> ${ETL_ELOG}/insert_orgs.out.${DTS}
psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${ETL_RUN}/insert_docs.sql > ${ETL_SLOG}/insert_docs.out.${DTS} 2> ${ETL_ELOG}/insert_docs.out.${DTS}
#psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${ETL_RUN}/update_orgs.sql > ${ETL_SLOG}/update_orgs.out.${DTS} 2> ${ETL_ELOG}/update_orgs.out.${DTS}
#psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${ETL_RUN}/update_srecs_org.sql > ${ETL_SLOG}/update_srecs_org.out.${DTS} 2> ${ETL_ELOG}/update_srecs_org.out.${DTS}
#psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${ETL_RUN}/update_srecs_folder.sql > ${ETL_SLOG}/update_srecs_folder.out.${DTS} 2> ${ETL_ELOG}/update_srecs_folder.out.${DTS}
#psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${ETL_RUN}/extract_folders.sql > ${ETL_SLOG}/extract_folders.out.${DTS} 2> ${ETL_ELOG}/extract_folders.out.${DTS}
#psql -h ${HOST} -p ${PORT} -U ${USER} -d ${DATABASE} -a -f ${ETL_RUN}/count_docs_folders.sql > ${ETL_SLOG}/count_docs_folders.out.${DTS} 2> ${ETL_ELOG}/count_docs_folders.out.${DTS}


#cat ${ETL_RUN}/extract_folders.out |awk '{print "mkdir -m 776 "$1}' |sort |uniq > ${ETL_DOCS}/make_dir.sh
#cat ${ETL_RUN}/extract_folders.out |awk '{print "mv ${WOSB_DOCS}/"$2" " $1"/"$3}' > ${ETL_DOCS}/copy_docs.sh

#cd ${ETL_DOCS}
#. ${ETL_DOCS}/make_dir.sh
#. ${ETL_DOCS}/copy_docs.sh

#rm ${ETL_DOCS}/make_dir.sh
#rm ${ETL_DOCS}/copy_docs.sh

#-----------------------------------------------------------------------------
# Move the documents to the S3 bucket recursive.
# The next 6 lines of code count the folders and documents under each folder.
#-----------------------------------------------------------------------------

#aws s3 mv --sse AES256 ${ETL_DOCS}/ s3://${S3_BUCKET}/ --recursive
#aws s3 cp --sse AES256 ${ETL_DOCS}/ s3://${S3_BUCKET}/ --recursive

#if [[ -f ${ETL_SLOG}/count_s3_folders.out ]]; then 
   #rm ${ETL_SLOG}/count_s3_folders.out  
#fi

#aws s3 ls s3://${S3_BUCKET} |grep PRE |awk '{print $2}' |sed 's/\///' > ${ETL_RUN}/s3_folders_list.out

#if [[ -f ${ETL_SLOG}/count_3s_folders.out ]]; then
   #rm ${ETL_SLOG}/count_3s_folders.out
#fi

#cat ${ETL_RUN}/s3_folders_list.out |while read i
#do
   #echo ${i} "|" `aws s3 ls s3://${S3_BUCKET}/${i} --recursive |wc -l` >> ${ETL_SLOG}/count_s3_folders.out.${DTS}
#done

#cat ${ETL_RUN}/s3_folders_list.out |wc -l > ${TFILE}
#echo "The total folders in ${S3_BUCKET} is: " `cat ${TFILE}` >> ${ETL_SLOG}/count_s3_folders.out.${DTS}


#-----------------------------------------------------------------------------
# Cleanup the etl_docs directory
#-----------------------------------------------------------------------------

#cat ${ETL_RUN}/extract_folders.out |awk '{print "rm -r "$1}' |sort |uniq > ${ETL_DOCS}/remove_dir.sh
#. ${ETL_DOCS}/remove_dir.sh
#rm ${ETL_DOCS}/remove_dir.sh


