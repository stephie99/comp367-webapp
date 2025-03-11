pipeline {
    agent any
    tools {
        maven "apache-maven-3.9.9" // Use the correct Maven installation name
    }
    environment {
        DOCKERHUB_USERNAME = credentials('dockerhub-username')
        DOCKERHUB_PASSWORD = credentials('dockerhub-password')
    }
    stages {
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
                bat 'echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin'
            }
        }
        stage('Docker Build') {
            steps {
                bat 'docker build -t $DOCKERHUB_USERNAME/maven-webapp:latest .'
            }
        }
        stage('Docker Push') {
            steps {
                bat 'docker push $DOCKERHUB_USERNAME/maven-webapp:latest'
            }
        }
    }
    post {
        always {
            echo 'Pipeline execution completed.'
        }
    }
}
