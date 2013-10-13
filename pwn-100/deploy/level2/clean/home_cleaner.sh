#!/bin/bash

# Cleaning my homedir every minute.

PATH=/bin:/usr/bin
DIR=/home/level2/clean
LOG=clean.log
ME=`basename $0`
SSH=level3.ssh.key

IFS="
"
cd $DIR

(
echo "CLEANING LOG"
echo "DATE: " `date`
echo "">> $DIR/$LOG
for FILE in `ls $DIR` 
do
    [ "$FILE" == "$LOG" ] && continue 
    [ "$FILE" == "$ME" ] && continue  
    [ "$FILE" == "$SSH" ] && continue  
  
    echo "Deleting file $FILE"
    eval rm -f $FILE 
    rm -f ./$FILE 
done
) > $DIR/$LOG
