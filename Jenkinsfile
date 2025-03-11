pipeline {
    agent any
    tools {
        maven "MAVEN3" // Name of Maven installation in Jenkins
    }
    environment {
        DOCKERHUB_USERNAME = credentials('dockerhub-username') // Jenkins credentials ID
        DOCKERHUB_PASSWORD = credentials('dockerhub-password') // Jenkins credentials ID
    }
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Build Maven Project') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Docker Login') {
            steps {
                sh 'echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin'
            }
        }
        stage('Docker Build') {
            steps {
                sh 'docker build -t $DOCKERHUB_USERNAME/maven-webapp:latest .'
            }
        }
        stage('Docker Push') {
            steps {
                sh 'docker push $DOCKERHUB_USERNAME/maven-webapp:latest'
            }
        }
    }
    post {
        always {
            echo 'Pipeline execution completed.'
        }
    }
}
