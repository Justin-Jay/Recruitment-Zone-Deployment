#!/bin/bash

WORKSPACE_DIR="/home/jenkins/FileBackUps/"

DATE=$(date +'%Y-%m-%d')
ZIPPASSWORD="Ram0Khum0"
LOG_FILE="/home/jenkins/FileBackUps/LogFileOutput/file_${DATE}.txt"

echo "Starting script execution..." >> "$LOG_FILE"

mkdir "./RecruitmentZoneApplication/"

cp -r "/RecruitmentZoneApplication/Files/" "./RecruitmentZoneApplication/Files"

zip -r -P ${ZIPPASSWORD} RecruitmentZoneApplicationFiles.zip "./RecruitmentZoneApplication/Files"

mv -r "./RecruitmentZoneApplicationFiles.zip" "/data/backups/"

#gsutil cp RecruitmentZoneApplicationFiles.zip "gs://recruitmentzoneapplication/${DATE}/" >> "$LOG_FILE" 2>&1

echo $DATE

echo "Script execution completed." >> "$LOG_FILE"

#unzip -P Ram0Khum0 ./RecruitmentZoneApplicationFiles.zip



