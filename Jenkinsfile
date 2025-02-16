pipeline {
    agent any
    tools {
        maven 'apache-maven-3.9.9'  // Use the configured Maven installation
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
