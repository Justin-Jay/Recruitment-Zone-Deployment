pipeline {
    agent {
        label 'RecruitmentZoneWeb-Test-1'
    }

    environment {


        WORKSPACE_DIR = "/home/jenkins/Recruitment-Zone/"

        branch_name = "main"

        git_repo = "git@github.com:Justin-Jay/Recruitment-Zone.git"

        SONAR_HOST_URL = "http://192.168.0.10:9000"

        SONAR_AUTH_TOKEN = "SONAR_TOKEN"

        SONAR_CONFIG_NAME = "recruitment-zone-test"


    }


    stages {


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

        stage("MVN C/I") {
            steps {
                dir("/home/jenkins/Recruitment-Zone/") {
                    sh """
                       mvn clean install 
                    """
                }
            }
        }


        stage("Sonar Checks") {
            steps {
                dir("/home/jenkins/Recruitment-Zone/") {
                    sh """ 
                       mvn verify sonar:sonar -Dsonar.projectKey=${SONAR_CONFIG_NAME} -Dsonar.host.url=${SONAR_HOST_URL} -Dsonar.login=${SONAR_AUTH_TOKEN}
                    """
                }
            }
        }



    }
}