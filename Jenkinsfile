pipeline {
    agent any
    tools {
        maven "apache-maven-3.9.9" // Ensure this matches the configured Maven installation name
    }
    environment {
        DOCKERHUB_USERNAME = credentials('dockerhub-username') // Make sure this credential ID is correct
        DOCKERHUB_PASSWORD = credentials('dockerhub-password') // Make sure this credential ID is correct
    }
    stages {
        stage('Debug Credentials') {
            steps {
                echo "DOCKERHUB_USERNAME: ${env.DOCKERHUB_USERNAME}" // Double-check this won't expose sensitive info
                echo "DOCKERHUB_PASSWORD length: ${env.DOCKERHUB_PASSWORD?.length()}" // Ensures the password variable is set
            }
        }
        stage('Test Docker Command') {
            steps {
                bat 'docker --version'
                bat 'docker info' // Validates Docker setup on Jenkins agent.
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
                bat 'echo %DOCKERHUB_PASSWORD% | docker login -u %DOCKERHUB_USERNAME% --password-stdin'
            }
        }
        stage('Docker Build') {
            steps {
                bat 'docker build -t %DOCKERHUB_USERNAME%/maven-webapp:latest .'
            }
        }
        stage('Docker Push') {
            steps {
                bat 'docker push %DOCKERHUB_USERNAME%/maven-webapp:latest'
            }
        }
    }
    post {
        always {
            echo 'Pipeline execution completed.'
        }
    }
}
