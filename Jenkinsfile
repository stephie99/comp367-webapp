pipeline {
    agent any

    environment {
        IMAGE_NAME = "ssanto43/lab3-local-maven-webapp"
        IMAGE_TAG = "1.0"
    }

    stages {
        stage('Checkout') { // (a) Check out stage [1 mark]
            steps {
                checkout scm
            }
        }

        stage('Build Maven Project') { // (b) Build maven project stage [1 mark]
            steps {
                script {
                    sh 'mvn clean package'
                }
            }
        }

        stage('Docker Login') { // (d) Docker login stage [2 marks]
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Docker Build') { // (e) Docker build stage [1 mark]
            steps {
                script {
                    sh "docker build -t $IMAGE_NAME:$IMAGE_TAG ."
                }
            }
        }

        stage('Docker Push') { // (f) Docker push stage [1 mark]
            steps {
                script {
                    sh "docker push $IMAGE_NAME:$IMAGE_TAG"
                }
            }
        }
    }
}
