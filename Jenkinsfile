pipeline {
    agent any
    tools {
       terraform 'terraform'
    }
    stages {

        stage('terraform format check') {
            steps{
                sh 'ls -la'
                sh 'cd ./AWS/envs/'
                sh 'terraform fmt'
            }
        }
        stage('terraform Init') {
            steps{
                sh 'ls -la'
                sh 'cd ./AWS/envs/'
                sh 'terraform init'
            }
        }
        stage('terraform plan') {
            steps{
                sh 'ls -la'
                sh 'cd ./AWS/envs/'
                sh 'ls -la'
                sh 'terraform plan  -var-file=./vars/dev.tfvars'
            }
        }
    }

    
}
