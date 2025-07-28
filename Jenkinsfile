pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "my-apache-site"
        CONTAINER_NAME = "apache-html"
        SONARQUBE_ENV = "SonarQube"  // Name from Jenkins SonarQube configuration
    }

    stages {

        stage('Clone Code from GitHub') {
            steps {
                git branch: 'main', url: 'https://github.com/vsn73/private_webpage.git'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv(SONARQUBE_ENV) {
                    sh """
                        sonar-scanner \
                        -Dsonar.projectKey=private_webpage \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=http://74.225.146.90:9000 \
                        -Dsonar.login=sonarqube-tokensec
                    """
                }
            }
        }

        stage('Quality Gate Check') {
            steps {
                script {
                    timeout(time: 2, unit: 'MINUTES') {
                        waitForQualityGate abortPipeline: true
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Stop Existing Container (if running)') {
            steps {
                sh """
                    if [ \$(docker ps -q -f name=$CONTAINER_NAME) ]; then
                        docker stop $CONTAINER_NAME
                        docker rm $CONTAINER_NAME
                    fi
                """
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run -d --name $CONTAINER_NAME -p 80:80 $DOCKER_IMAGE'
            }
        }
    }

    post {
        success {
            echo "✅ Deployment successful! Visit your server's IP to view cafe.html"
        }
        failure {
            echo "❌ Deployment failed."
        }
    }
}
