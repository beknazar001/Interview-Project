pipeline {
    agent any
    tools {
       terraform 'terraform'
    }
    stages {

        stage('terraform format check') {
            steps{
                sh 'terraform fmt'
            }
        }
        stage('terraform Init') {
            steps{
                sh 'terraform init'
            }
        }
        stage('terraform apply') {
            steps{
                sh 'terraform plan --auto-approve'
            }
        }
    }

    
}