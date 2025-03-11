pipeline {
    agent any
    tools {
        maven "apache-maven-3.9.9" // Ensure this matches the configured Maven installation name
    }
    environment {
        DOCKERHUB_USERNAME = credentials('dockerhub-username') // Ensure correct credential ID
        DOCKERHUB_PASSWORD = credentials('dockerhub-password') // Ensure correct credential ID
    }
    stages {
        stage('Debug Credentials') {
            steps {
                script {
                    echo "DOCKERHUB_USERNAME: ${DOCKERHUB_USERNAME}"
                    echo "DOCKERHUB_PASSWORD length: ${DOCKERHUB_PASSWORD.length()}" // Ensure password is set
                }
            }
        }
        stage('Test Docker Command') {
            steps {
                bat 'docker --version'
                bat 'docker info' // Validates Docker setup on Jenkins agent
            }
        }
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Build Maven Project') {
            steps {
                bat 'mvn clean package'
            }
        }
        stage('Docker Login') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerhub-password', variable: 'DOCKERHUB_TOKEN')]) {
                        bat "echo ${DOCKERHUB_TOKEN} | docker login -u ${DOCKERHUB_USERNAME} --password-stdin"
                    }
                }
            }
        }
        stage('Docker Build') {
            steps {
                bat "docker build -t ${DOCKERHUB_USERNAME}/maven-webapp:latest ."
            }
        }
        stage('Docker Push') {
            steps {
                bat "docker push ${DOCKERHUB_USERNAME}/maven-webapp:latest"
            }
        }
    }
    post {
        always {
            echo 'Pipeline execution completed.'
        }
    }
}
