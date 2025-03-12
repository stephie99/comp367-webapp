pipeline {
    agent any

    tools {
        maven 'Maven 3.9.9' 
    }

    environment {
        DOCKER_HUB_USER = 'ssanto43' 
        IMAGE_NAME = 'ssantos123' 
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/donaldazhuga/JenkinsLab2.git'
            }
        }

        stage('Build Maven Project') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                bat 'mvn test'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-credentials', variable: 'DOCKER_HUB_PASSWORD')]) {
                    bat "echo %DOCKER_HUB_PASSWORD% | docker login -u %DOCKER_HUB_USER% --password-stdin"
                }
            }
        }

        stage('Docker Build') {
            steps {
                bat "docker build -t %DOCKER_HUB_USER%/%IMAGE_NAME% ."
            }
        }

        stage('Docker Push') {
            steps {
                bat "docker push %DOCKER_HUB_USER%/%IMAGE_NAME%"
            }
        }

        stage('Deploy') {
            steps {
                bat "docker run -d -p 9090:8080 %DOCKER_HUB_USER%/%IMAGE_NAME%"
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
} // Closing brace for the pipeline block
