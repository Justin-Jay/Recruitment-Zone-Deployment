pipeline {
    agent {
        label 'RecruitmentZoneWeb-Prod-1'
    }

    environment {
        WORKSPACE_DIR = "/home/jenkins/FileBackUps/"
        REPO_WORKSPACE = "/home/jenkins/Archiver/"
        ENV_FILE_SOURCE = "/home/jenkins/FileBackUps/filesbackup.env"
        composeDir="/home/jenkins/Recruitment-Zone-Deployment/recruitmentzone-backup/"

    }

    stages {


        stage('Run Back Up Script') {
            steps {
                script {
                    // Check if the repository already exists in the workspace directory
                    dir("${WORKSPACE_DIR}") {

                        sh """
                         ./file_backup.sh 
                       """
                    }

                }
            }
        }

        stage("Run Backup Container") {
            steps {
                dir("${composeDir}") {
                    sh """
                        cp -r ${ENV_FILE_SOURCE}  ${composeDir}var/filesbackup.env
                        docker-compose -f docker-compose.backup.yml up -d
                        """
                }
            }
        }

        stage('Run Script') {
            steps {
                script {
                    // Check if the repository already exists in the workspace directory
                    dir("${WORKSPACE_DIR}") {

                        sh """
                         ./zip_archive.sh 
                       """
                    }

                }
            }
        }

    }

}



