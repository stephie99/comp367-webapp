pipeline {
    agent any
    tools {
        maven "MAVEN3" // The Maven version configured in Jenkins
    }
    environment {
        DOCKERHUB_USERNAME = credentials('dockerhub-username')
        DOCKERHUB_PASSWORD = credentials('dockerhub-password')
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/stephie99/comp367-webapp.git'
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
            echo 'Pipeline execution completed!'
        }
    }
}
