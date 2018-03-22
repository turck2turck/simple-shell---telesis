cat /dev/null > test.out

cat image.txt |while read i
do
   echo "FIND ${i}***" >> test.out
   aws s3 ls s3://atero/attachment/${i} >> test.out
done
