pipeline {
    agent {
        label 'RecruitmentZoneWeb-Test-1'
    }

    environment {
        WORKSPACE_DIR = "/home/jenkins/Recruitment-Zone/"
        branch_name = "main"
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



        stage("MVN C/I") {
            steps {
                dir("${WORKSPACE_DIR}") {
                    sh """
                       mvn clean install 
                       """
                }
            }
        }



        stage('Build latest Image') {
            steps {
                script {
                    // Check if the repository already exists in the workspace directory
                    dir("${WORKSPACE_DIR}") {
                        sh """
                        docker build -t justinmaboshego/recruitmentzone:latest .
                        """

                    }

                }
            }
        }
        stage('Push Latest Image') {
            steps {
                // Execute your shell scripts here
                sh """
                docker push justinmaboshego/recruitmentzone:latest
                """
                // Add more shell scripts or commands as needed
            }
        }


    }

}
