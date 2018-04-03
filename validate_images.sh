#!/bin/bash
set +x
umask 137
###########################################################################################
#
# Program: validate_images.sh
# Date:    2/5/2018
# Author:  J.Turck
# User:
#
# Purpose: insert or update records in the public.address table.
#
###########################################################################################
source /home/ubuntu/config/init.cfg
export PGM_NAME=validate_images
export SQL_PGM=sel_link.sql
export SQL_OUT=link.txt

if [[ -s ${HOME}/.pwx ]]; then
   . ${HOME}/.pwx
else
   echo ""
   echo ""
   echo "ERROR: password file ${HOME}/.pwx is empty or does not exist"
   echo "       processing terminating now."
   echo ""
   echo ""
   exit 99
fi

echo "select link from public.product_attachment " > ${SQLDIR}/${SQL_PGM}
psql -h ${HOST} -U ${USER} -d ${DATABASE} -a -f ${SQLDIR}/${SQL_PGM} > ${SQLDIR}/${SQL_OUT}
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Error with the ${SQL_PGM} command."
      exit 3
   fi

tail -n +4 ${SQLDIR}/${SQL_OUT} > /tmp/1.txt && mv /tmp/1.txt ${SQLDIR}/${SQL_OUT}
perl -pne 's/(.*)\//$1\/"/' ${SQLDIR}/${SQL_OUT}> /tmp/1.txt
cat /tmp/1.txt |sed 's/^[ \t]*//;s/[ \t]*$//' > /tmp/2.txt
cat /tmp/2.txt |sed 's/$/"/' > ${SQLDIR}/${SQL_OUT}

echo "Running ${PGM_NAME} on ${DTS} in ${HOST} " > ${ELOGDIR}/${PGM_NAME}.err
echo "Running ${PGM_NAME} on ${DTS} in ${HOST} " > ${LOGDIR}/${PGM_NAME}.out

cat ${SQLDIR}/${SQL_OUT} | while read i
do
   aws s3 ls s3://atero/attachment/${i} >> ${LOGDIR}/${PGM_NAME}.out
es=${?}
   if [[ ${es} -ne 0 ]]; then
      echo "Can't find ${i} in S3://atero/attachment." >> ${LOGDIR}/${PGM_NAME}.out
   fi
done

exit 0
