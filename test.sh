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
   /usr/local/bin/aws s3 ls ${bucket}/${filename}> /tmp/1.txt
#echo "Temp count is:"
#cat /tmp/1.txt
#   new_file_count=`wc -l</tmp/1.txt`
#   if [ $new_file_count -eq 0 ]
#   then
#      echo "The IF count is: ${new_file_count}"
#   else
#      echo "The ELSE count is: ${new_file_count}"
#   fi

done

