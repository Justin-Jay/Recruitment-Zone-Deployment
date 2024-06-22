#!/bin/bash

#WORKSPACE_DIR="/home/jenkins/BlogBackUps/"

DATE=$(date +'%Y-%m-%d')
ZIPPASSWORD="Ram0Khum0"
#LOG_FILE="/home/jenkins/FileBackUps/LogFileOutput/blagbackups/file_${DATE}.txt"

echo "Starting script execution..."

mkdir "./RecruitmentZoneApplication/"

cp -r "/RecruitmentZoneApplication/BlogImages/" "./RecruitmentZoneApplication/Images/"

zip -r -P ${ZIPPASSWORD} RZBlogImages.zip "./RecruitmentZoneApplication/Images"

cp -r "./RZBlogImages.zip" "/data/backups/"

#gsutil cp RecruitmentZoneApplicationBlogImages.zip "gs://recruitmentzoneapplication/${DATE}/" >> "$LOG_FILE" 2>&1

echo $DATE

rm -r RZBlogImages.zip
rm -r ./RecruitmentZoneApplication/

#echo "Script execution completed." >> "$LOG_FILE"

#unzip -P Ram0Khum0 ./RecruitmentZoneApplicationBlogImages.zip



