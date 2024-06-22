pipeline {
    agent {
        label 'RecruitmentZoneWeb-Prod-1'
    }

    environment {

        secrets_source = "/home/jenkins/secrets/recruitmentzone"

        compose_dir = "/home/jenkins/Recruitment-Zone-Deployment/recruitmentzone/"

        recruitmentzone_volume_logs_mount = "/RecruitmentZoneApplication/Logs"

        recruitmentzone_volume_files_mount = "/RecruitmentZoneApplication/Files"

        recruitmentzone_var_dir = "/home/jenkins/Recruitment-Zone-Deployment/recruitmentzone/var/"

        var_file_name = "recruitmentzone.env"

        container_name = "recruitment-zone-application"

        WORKSPACE_DIR = "/home/jenkins/Recruitment-Zone/"

        git_repo = "git@github.com:Justin-Jay/Recruitment-Zone.git"

    }

    stages {


        stage('Clone Repository') {
            steps {
                script {
                    // Check if the repository already exists in the workspace directory
                    dir("${WORKSPACE_DIR}") {
                        deleteDir()
                    }
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


        stage('Pull Image') {
            steps {
                // Execute your shell scripts here
                sh """
                docker pull justinmaboshego/recruitmentzone:${IMAGE_TAG}
                """
                // Add more shell scripts or commands as needed
            }
        }

        stage('Stop container') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh """
                    docker stop ${container_name}
                    """
                }

            }
        }


        stage('Remove Old Container') {
            steps {

                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh """
                    docker rm ${container_name}
                    """
                }

            }
        }

        stage('Copy Variables') {
            steps {
                sh """
                cp ${secrets_source}/${var_file_name}* ${recruitmentzone_var_dir}
                """
                // cp $secrets_source/$mysql_cnf_file_name* ${deployment_conf}
            }
        }


        stage('Restart Container with Image') {
            steps {
                sh """
                cd ${compose_dir} && IMAGE_TAG=${IMAGE_TAG} docker-compose -f docker-compose.yml up -d
                """
            }
        }
    }

}
