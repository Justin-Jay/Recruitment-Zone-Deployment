pipeline {
    agent {
        label 'MySQL-Database-Prod-1'
    }
    //  'MySQL-Database-Test-1'
    // 'MySQL-Database-Prod-1'

    environment {

        WORKSPACE_DIR = "/home/jenkins/mysql-docker-deployment/"
        MYSQL_VERSION = "8.3.0"
        container_name = "rzdatabase"

        secrets_source = "/home/jenkins/secrets/mysql"
        deployment_conf = "/home/jenkins/mysql-docker-deployment/mysql/conf"
        compose_dir = "/home/jenkins/mysql-docker-deployment/mysql"

        schema_init_file_name = "init.sql"
        spring_batch_schema_init_file_name = "spring_batch.sql"
        data_init_file_name = "data.sql"
        mysql_var_file_name = "mysql-vars.env"
        mysql_cnf_file_name = "my.cnf"
        // volume_mount = "/var/lib/mysql"
        user = "jenkins"
        git_repo = "https://github.com/Justin-Jay/mysql-docker-deployment.git"
        branch_name = "main"
        mysql_volume_mount = "/home/jenkins/var/lib/mysql"
    }

    stages {

        stage('WHICH CONTAINER') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh """
                    echo ${container_name}
                    """
                }
            }
        }


        stage('Clone Repository') {
            steps {
                script {
                    // Check if the repository already exists in the workspace directory
                    def repoExists = fileExists("${WORKSPACE_DIR}/.git")

                    if (!repoExists) {
                        // Clone the repository if it doesn't already exist
                        sh "git clone --depth 1 --branch ${branch_name} ${git_repo} ${WORKSPACE_DIR}"
                    } else {
                        echo "Repository already exists in workspace. Skipping clone."
                    }
                }
            }
        }


        stage('Copy Variables') {
            steps {
                sh """
                    mkdir -p ${deployment_conf} 
                    mkdir -p ${mysql_volume_mount}
                    cp ${secrets_source}/${mysql_var_file_name}* ${deployment_conf} 
                    cp ${secrets_source}/${schema_init_file_name}* ${deployment_conf} 
                    cp ${secrets_source}/${spring_batch_schema_init_file_name} ${deployment_conf} 
                    cp ${secrets_source}/${data_init_file_name}* ${deployment_conf}

                    """
                // cp $secrets_source/$mysql_cnf_file_name* ${deployment_conf}
            }
        }
/*
        stage('Change Permissions') {
            steps {
                sh """
                         sudo chmod +x ${WORKSPACE_DIR}mysql/conf/${schema_init_file_name}
                         sudo chmod +x ${WORKSPACE_DIR}mysql/conf/${spring_batch_schema_init_file_name}
                         sudo chmod +x ${WORKSPACE_DIR}mysql/conf/${data_init_file_name}


                         sudo chown ${user}:${user} ${WORKSPACE_DIR}mysql/conf/mysql-vars.env
                         sudo chown ${user}:${user} ${WORKSPACE_DIR}mysql/conf/${schema_init_file_name}
                         sudo chown ${user}:${user} ${WORKSPACE_DIR}mysql/conf/${spring_batch_schema_init_file_name}
                         sudo chown ${user}:${user} ${WORKSPACE_DIR}mysql/conf/${data_init_file_name}
                         """
                         //   sudo chmod +x ${WORKSPACE_DIR}mysql/conf/${$mysql_cnf_file_name}
            }
        }
*/

        stage('Stopping old container') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh """
                    docker stop ${container_name}
                    """
                }
            }
        }


        stage('Removing old image') {
            steps {

                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh """
                        docker rm ${container_name}
                        """
                }

            }

        }
        /*    stage('Pulling MySQL Image') {
                steps {
                    sh """
                        docker pull mysql:${MYSQL_VERSION}
                        """
                }
            }*/

        stage('Start Container') {
            steps {
                sh "cd ${compose_dir} && docker-compose -f docker-compose.mysql.yml up -d"
            }
        }


    }
}