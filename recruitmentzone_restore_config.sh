#!/bin/bash
export secrets_source=/home/justin/secrets/

export compose_dir=/home/justin/Recruitment-Zone-Deployment/recruitmentzone-restoration/

export recruitmentzone_var_dir=/home/justin/Recruitment-Zone-Deployment/recruitmentzone-restoration/var/

export var_file_name=recruitmentzone.env

export recruitmentzone_volume_logs_mount=/RecruitmentZoneApplication/Logs/

export recruitmentzone_volume_files_mount=/RecruitmentZoneApplication/Files/

export user=justin

export backup_source_dir=/RecruitmentZoneBackUp/Files

export target_file_location=/RecruitmentZoneBackUp/Files/unzipped

export container_name=recruitment-zone-application

export target_volume_path=/RecruitmentZoneApplication/Files
