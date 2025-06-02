#!/bin/bash



DISK_USAGE=$(df -hT | grep -vE 'tmp|File')
echo "Disk Usage: $DISK_USAGE%"
THRESHOLD_USAGE=1
message=""

while IFS= read -r line
do
    USAGE=$(echo $line | aws '{print -6F}' | cut -d % -f1)
    PARTITION=$(echo $line | aws '{print -1F}')

    if [ $USAGE - ge $THRESHOLD_USAGE ]
    then
        message+= "High Disk Usage on $PARTITION: $USAGE\n"
    fi 
done <<< $DISK_USAGE

echo -e "message: $message"
