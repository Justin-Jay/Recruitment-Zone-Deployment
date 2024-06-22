pipeline {
    agent {
        label 'RecruitmentZoneWeb-Test-1'
    }

    environment {

        secrets_source = "/home/jenkins/secrets/recruitmentzone"

        compose_dir = "/home/jenkins/Recruitment-Zone-Deployment/recruitmentzone/"

        recruitmentzone_var_dir = "/home/jenkins/Recruitment-Zone-Deployment/recruitmentzone/var/"

        var_file_name = "recruitmentzone.env"

        container_name = "recruitment-zone-application"


    }

    stages {


        stage('Stop container') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh """
                     cd ${compose_dir} 
                     docker-compose -f docker-compose.yml down
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
