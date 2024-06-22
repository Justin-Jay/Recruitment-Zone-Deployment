pipeline {
    agent {
        label 'MySQL-Database-Test-1'
    }
    // 'MySQL-Database-Prod-1'

    environment {

        WORKSPACE_DIR = "/home/jenkins/mysql-docker-deployment/"
        SECRETS_SOURCE = "/home/jenkins/secrets/database-deployment/mysql"
        DEPLOYMENT_CONF_PATH = "/home/jenkins/mysql-docker-deployment/mysql/conf"
        COMPOSE_DIR = "/home/jenkins/mysql-docker-deployment/mysql"
        MYSQL_SCHEMA_FILE = "init.sql"
        MYSQL_VERSION = "8.3.0"
        SPRING_BATCH_DL_FILE = "spring_batch.sql"
        MYSQL_DATA_INIT = "data.sql"
        MYSQL_VAR_FILE = "mysql-vars.env"
        MYSQL_CNF_FILE_NAME = "my.cnf"
        // volume_mount = "/var/lib/mysql"
        user = "jenkins"
        container_name = "rzdatabase"

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


        /*      stage('Clone Repository') {
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
              }*/


        /*    stage('Copy Variables') {
                steps {
                    sh """
                        cp ${SECRETS_SOURCE}/${MYSQL_VAR_FILE}* ${DEPLOYMENT_CONF_PATH}
                        cp ${SECRETS_SOURCE}/${MYSQL_SCHEMA_FILE}* ${DEPLOYMENT_CONF_PATH}
                        cp ${SECRETS_SOURCE}/${SPRING_BATCH_DL_FILE} ${DEPLOYMENT_CONF_PATH}
                        cp ${SECRETS_SOURCE}/${MYSQL_DATA_INIT}* ${DEPLOYMENT_CONF_PATH}

                        """
                    // cp $SECRETS_SOURCE/$MYSQL_CNF_FILE_NAME* ${DEPLOYMENT_CONF_PATH}
                }
            }*/
/*
        stage('Change Permissions') {
            steps {
                sh """
                         sudo chmod +x ${WORKSPACE_DIR}mysql/conf/${MYSQL_SCHEMA_FILE}
                         sudo chmod +x ${WORKSPACE_DIR}mysql/conf/${SPRING_BATCH_DL_FILE}
                         sudo chmod +x ${WORKSPACE_DIR}mysql/conf/${MYSQL_DATA_INIT}


                         sudo chown ${user}:${user} ${WORKSPACE_DIR}mysql/conf/mysql-vars.env
                         sudo chown ${user}:${user} ${WORKSPACE_DIR}mysql/conf/${MYSQL_SCHEMA_FILE}
                         sudo chown ${user}:${user} ${WORKSPACE_DIR}mysql/conf/${SPRING_BATCH_DL_FILE}
                         sudo chown ${user}:${user} ${WORKSPACE_DIR}mysql/conf/${MYSQL_DATA_INIT}
                         """
                         //   sudo chmod +x ${WORKSPACE_DIR}mysql/conf/${$MYSQL_CNF_FILE_NAME}
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
                sh "cd ${COMPOSE_DIR} && docker-compose -f docker-compose.mysql.yml up -d"
            }
        }


    }
}