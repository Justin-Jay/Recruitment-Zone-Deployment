#!/bin/bash

# Add any pre-startup commands here
echo "Running pre-startup tasks..."

source ./recruitmentzone_config.sh

#docker-compose -f docker-compose.test.yml down -v --remove-orphans

sudo mkdir -p $recruitmentzone_volume_logs_mount/

sudo chown $user:$user $recruitmentzone_volume_logs_mount

sudo mkdir -p $recruitmentzone_volume_files_mount/

sudo chown $user:$user $recruitmentzone_volume_files_mount

# variables file to env location

cp $secrets_source/$var_file_name* $recruitmentzone_var_dir

cd $compose_dir

docker-compose -f docker-compose.test.yml up -d

echo "recruitmentzone has been deployed"

echo "Running Portainer"

#/home/justin/recruitment-zone-deployment/portainer.sh

# Add any post-startup commands here
echo "Running post-startup tasks..."
