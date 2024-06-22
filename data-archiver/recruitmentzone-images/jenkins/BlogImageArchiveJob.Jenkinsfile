pipeline {
    agent {
        label 'RecruitmentZoneWeb-Prod-1'
    }


    environment {
        WORKSPACE_DIR = "/home/jenkins/BlogBackUps/"
        BACKUPS_DIR = "/data/backups/"
        //REPO_WORKSPACE = "/home/jenkins/Archiver/"
        ENV_FILE_SOURCE = "/home/jenkins/secrets/recruitmentzone/BlogBackUp.env"
        composeDir = "/home/jenkins/Recruitment-Zone-Deployment/recruitmentzone-backup/"
    }

    stages {

        stage('Clean Up Old Zips') {
            steps {
                script {
                    // Check if the repository already exists in the workspace directory
                    sh """
                           cd ${BACKUPS_DIR}
                           rm -r RZBlogImages.zip
                        """
                }
            }
        }


        stage('Run Back Up Script') {
            steps {
                script {
                    // Check if the repository already exists in the workspace directory
                    dir("${WORKSPACE_DIR}") {
                        sh """
                         ./blogImage_backup.sh 
                       """
                    }

                }
            }
        }

        stage("Run Backup Container") {
            steps {
                dir("${composeDir}") {
                    sh """
                        cp -r ${ENV_FILE_SOURCE}  ${composeDir}var/BlogBackUp.env
                        docker-compose -f docker-compose.archiver.yml down
                        docker-compose -f docker-compose.archiver.yml up -d
                        """
                }
            }
        }

    }

}



