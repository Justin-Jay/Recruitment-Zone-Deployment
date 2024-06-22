#!/bin/bash

DATE=$(date +'%Y-%m-%d')

TARGET_DIR="/data/backups/archived/${DATE}/"

cd "/data/backups/"

mkdir ${TARGET_DIR}

#cp -r "/home/jenkins/FileBackUps/RecruitmentZoneApplicationFiles.zip" ${TARGET_DIR}
mv "/home/jenkins/FileBackUps/RecruitmentZoneApplicationFiles.zip" ${TARGET_DIR}


echo "Zip file archived."


