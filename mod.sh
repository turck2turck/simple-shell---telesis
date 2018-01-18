#!/bin/bash
IN_DIR=/home/ubuntu/export/atero
infile=${IN_DIR}/products.csv
RUN_DATE=`date`

  sed -i 's/\"\"/ inch /g' ${infile}
./remove_cr.awk ${infile} > /tmp/0.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$2)} 1' /tmp/0.csv > /tmp/1.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$4)} 1' /tmp/1.csv > /tmp/2.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$6)} 1' /tmp/2.csv > /tmp/3.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$8)} 1' /tmp/3.csv > /tmp/4.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$10)} 1' /tmp/4.csv > /tmp/0.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$12)} 1' /tmp/0.csv > /tmp/1.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$14)} 1' /tmp/1.csv > /tmp/2.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$16)} 1' /tmp/2.csv > /tmp/3.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$18)} 1' /tmp/3.csv > /tmp/4.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$20)} 1' /tmp/4.csv > /tmp/5.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$22)} 1' /tmp/5.csv > /tmp/0.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$24)} 1' /tmp/0.csv > /tmp/1.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$26)} 1' /tmp/1.csv > /tmp/2.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$28)} 1' /tmp/2.csv > /tmp/3.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$30)} 1' /tmp/3.csv > /tmp/4.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$32)} 1' /tmp/4.csv > /tmp/5.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$34)} 1' /tmp/5.csv > /tmp/0.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$36)} 1' /tmp/0.csv > /tmp/1.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$38)} 1' /tmp/1.csv > /tmp/2.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$40)} 1' /tmp/2.csv > /tmp/3.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$42)} 1' /tmp/3.csv > /tmp/4.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$44)} 1' /tmp/4.csv > /tmp/5.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$46)} 1' /tmp/5.csv > /tmp/0.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$48)} 1' /tmp/0.csv > /tmp/1.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$50)} 1' /tmp/1.csv > /tmp/2.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$52)} 1' /tmp/2.csv > /tmp/3.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$54)} 1' /tmp/3.csv > /tmp/4.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$56)} 1' /tmp/4.csv > /tmp/5.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$58)} 1' /tmp/5.csv > /tmp/0.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$60)} 1' /tmp/0.csv > /tmp/1.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$62)} 1' /tmp/1.csv > /tmp/2.csv
   awk 'BEGIN{FS=OFS="\""} {gsub(/\,/,";",$64)} 1' /tmp/2.csv > /tmp/3.csv
   sed -i 's/\"//g' /tmp/3.csv
   sed -i 's// /g' /tmp/3.csv
   mv /tmp/3.csv ${IN_DIR}/clean_products.csv
