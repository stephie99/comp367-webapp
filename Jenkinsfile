pipeline {
    agent any
    tools {
        maven 'apache-maven-3.9.9'
    }
    environment {
        DOCKER_HUB_USER = 'ssanto43'
        IMAGE_NAME = 'jenkins-docker-lab3'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/stephie99/comp367-webapp.git'
            }
        }
        stage('Debug Workspace') {
            steps {
                // List all files and directories in the Jenkins workspace
                bat 'dir /S /B'
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
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', 
                    usernameVariable: 'DOCKER_HUB_USER', 
                    passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                    bat "docker login -u %DOCKER_HUB_USER% -p \"%DOCKER_HUB_PASSWORD%\""
                }
            }
        }
        stage('Docker Build') {
    		steps {
        		bat 'docker build -t %DOCKER_HUB_USER%/%IMAGE_NAME%:latest -f Dockerfile .'
    		}
		}
        // stage('Docker Build') {
        //     steps {
        //         bat "docker build -t %DOCKER_HUB_USER%/%IMAGE_NAME%:latest ."
        //     }
        // }
        stage('Docker Push') {
            steps {
                bat "docker push %DOCKER_HUB_USER%/%IMAGE_NAME%:latest"
            }
        }
        stage('Deploy') {
            steps {
                bat "docker run -d -p 8080:8080 %DOCKER_HUB_USER%/%IMAGE_NAME%:latest"
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
}
