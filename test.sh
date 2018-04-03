#!/bin/bash
set +x
umask 137
source /home/ubuntu/config/init.cfg
export PGM_NAME=validate_images
export SQL_PGM=sel_link.sql
export SQL_OUT=link2.txt
export bucket=s3://atero/attachment


cat ${SQLDIR}/${SQL_OUT} | while read filename
do
echo "the file is: ${bucket}/${filename} "
   count_file=$((aws s3 ls ${bucket}/${filename}|wc -l))
   if [[ ${count_file} -ne 1 ]]; then
    echo "The IF count is: ${count_file}"
   else
    echo "The ELSE count is: ${count_file}"
   fi

done

exit 0
