pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "my-apache-site"
        CONTAINER_NAME = "apache-html"
    }

    stages {
        stage('Clone Code from GitHub') {
            steps {
                git branch: 'main', url: 'https://github.com/vsn73/private_webpage.git'
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
