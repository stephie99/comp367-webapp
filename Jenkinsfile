pipeline {
    agent any
    tools {
        maven "apache-maven-3.9.9" // Ensure this matches the configured Maven installation name
    }
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials') // Single credential ID
    }
    stages {
        stage('Debug Credentials') {
            steps {
                script {
                    echo "DOCKERHUB_CREDENTIALS length: ${DOCKERHUB_CREDENTIALS.length()}" // Ensure credentials are set
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
                    withCredentials([string(credentialsId: 'dockerhub-credentials', variable: 'DOCKERHUB_TOKEN')]) {
                        bat "echo ${DOCKERHUB_TOKEN} | docker login -u ${DOCKERHUB_TOKEN.split(':')[0]} --password-stdin"
                    }
                }
            }
        }
        stage('Docker Build') {
            steps {
                bat "docker build -t ${DOCKERHUB_TOKEN.split(':')[0]}/maven-webapp:latest ."
            }
        }
        stage('Docker Push') {
            steps {
                bat "docker push ${DOCKERHUB_TOKEN.split(':')[0]}/maven-webapp:latest"
            }
        }
    }
    post {
        always {
            echo 'Pipeline execution completed.'
        }
    }
}
