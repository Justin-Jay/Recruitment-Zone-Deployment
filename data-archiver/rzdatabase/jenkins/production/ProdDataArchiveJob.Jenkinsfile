pipeline {
    agent {
        label 'MySQL-Database-Prod-1'
    }
    //  'MySQL-Database-Test-1'
    // 'MySQL-Database-Prod-1'

    environment {

        mysql_backup_folder = "/home/jenkins/data/backups"
        database_file_name = "all-databases.sql"
        mysql_backup_vars_source = "/home/jenkins/secrets/database-deployment/mysql-archiver"
        mysql_arch_vars = "mysql-archiver-vars.env"
        google_key_source = "/home/jenkins/secrets/google-key"
        api_key_name = "recruitmentzone-Prod.json"

        mysql_backup_init_target = "/home/jenkins/mysql-docker-deployment/mysql-backup/data/backups/"
        mysql_backup_vars_target = "/home/jenkins/mysql-docker-deployment/mysql-backup/data-archiver/"
        google_key_target = "/home/jenkins/mysql-docker-deployment/mysql-backup/key/"
        bk_compose_dir = "/home/jenkins/mysql-docker-deployment/mysql-backup/"


        container_name = "rzdatabase"

        MYSQL_USER = "root"
        MYSQL_PASSWORD = "rootPassword"

    }

    stages {

        /* stage("Instance clean up") {
                steps {
                    dir("/home/jenkins/mysql-docker-deployment/mysql-backup/") {
                        sh """

                        echo "Instance clean up"

                        docker-compose -f docker-compose.archiver.yml down -v --remove-orphans

                        """
                    }
                }
            }*/


        stage("Backing up databases") {
            steps {
                dir("/home/jenkins/mysql-docker-deployment/mysql-backup/") {
                    sh """ 
                    
                    echo "Backing up databases"
                    mkdir -p $mysql_backup_folder/
                    docker exec $container_name sh -c 'exec mysqldump --all-databases -u"$MYSQL_USER" -p"$MYSQL_PASSWORD"' > "$mysql_backup_folder/$database_file_name"

                    """
                }
            }
        }


        stage("Copying back up source to target") {
            steps {
                dir("/home/jenkins/mysql-docker-deployment/mysql-backup/") {
                    sh """ 
                    
                     echo "Copying back up source to target folder"
                     echo "back up folder: $mysql_backup_folder Database file name $database_file_name Target folder $mysql_backup_init_target "
                     mkdir -p $mysql_backup_init_target
                     cp  $mysql_backup_folder/$database_file_name*  $mysql_backup_init_target

                    """
                }
            }
        }


        stage("Copying env variables target folder") {
            steps {
                dir("/home/jenkins/mysql-docker-deployment/mysql-backup/") {
                    sh """ 
                    
                     echo "Copying env variables target folder"
                     mkdir -p $mysql_backup_vars_target
                     cp $mysql_backup_vars_source/$mysql_arch_vars* $mysql_backup_vars_target
                     #chmod 400 $mysql_backup_vars_target/$mysql_arch_vars

               
                     echo "Copying key target folder"
                     mkdir -p $google_key_target

                     cp $google_key_source/$api_key_name* $google_key_target

                    """
                }
            }
        }


        stage("Creating Archive Container") {
            steps {
                dir("/home/jenkins/mysql-docker-deployment/mysql-backup/") {
                    sh """ 
                                     
                    docker-compose -f docker-compose.archiver.yml up -d

                    """
                }
            }
        }

    }
}