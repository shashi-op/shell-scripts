#!/bin/bash


#The grep -vE 'tmp|File' command is used to exclude lines that contain either "tmp" or "File" when searching through a file or command output.
#-d % → Specifies % as the delimiter.
#-f1 → Extracts the first field (text before the % character)

DISK_USAGE=$(df -hT | grep -vE 'tmp|File')
THRESHOLD_USAGE=1
message=""

while IFS= read -r line
do
    USAGE=$(echo $line | awk '{print $6F}' | cut -d % -f1)
    PARTITION=$(echo $line | awk '{print $1F}')

   if [ "$USAGE" -ge "$THRESHOLD_USAGE" ]
    then
        message+= "High Disk Usage on $PARTITION: $USAGE\n"
    fi 
done <<< $DISK_USAGE

echo -e "message: $message"
