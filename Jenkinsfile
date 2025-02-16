pipeline {
    agent any
    tools {
        maven 'Maven 3.x'  // Use the configured Maven installation
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                bat 'mvn clean package'
            }
        }
        stage('Test') {
            steps {
                bat 'mvn test'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deployment step'
            }
        }
    }
}
