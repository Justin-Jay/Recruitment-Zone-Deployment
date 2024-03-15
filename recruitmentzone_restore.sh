#!/bin/bash

source ./recruitmentzone_restore_config.sh

echo "Running Restoration Tasks..."

cd $compose_dir

#docker-compose -f docker-compose.test.yml down -v --remove-orphans

sudo mkdir $recruitmentzone_volume_logs_mount

chown $user:$user $recruitmentzone_volume_logs_mount

sudo mkdir $recruitmentzone_volume_files_mount

chown $user:$user $recruitmentzone_volume_files_mount

sudo mkdir $target_file_location

chown $user:$user $target_file_location


 # variables file to env location

cp $secrets_source/$var_file_name* $recruitmentzone_var_dir

 # untar
cd $backup_source_dir

tar xvf $backup_source_dir/backup.tar -C $target_file_location

 # Copy the untarred directory into the running container

docker cp $target_file_location $container_name:$target_volume_path

echo "Files $target_file_location have been copied to $target_volume_location"

cd $compose_dir

docker-compose -f docker-compose.test.yml up -d

echo "recruitmentzone has been deployed"

echo "Running Portainer"

#source ./portainer.sh/

# Add any post-startup commands here
echo "Running post-startup tasks..."




