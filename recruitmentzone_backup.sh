#!/bin/bash

source ./recruitmentzone_backup_config.sh

echo "Creating Back Up Container..."

sudo mkdir -p $target_backup_dir

chown $user:$user $target_backup_dir

cd $compose_dir

docker run --rm --volumes-from $container_name -v $target_backup_dir:$volume_dir --name $container ubuntu tar cvf $volume_dir/$backup_tar_name $volume_name
# untar
cd $target_backup_dir

#tar xvf $target_backup_dir/$backup_tar_name -C $backup_target_dir

cp $target_backup_dir/$backup_tar_name* $backup_target_dir

cp $secrets_source/$env_file_name* $env_file_dir

#cd $compose_dir

#docker-compose -f docker-compose.backup.yml up -d

echo "Back up done..."