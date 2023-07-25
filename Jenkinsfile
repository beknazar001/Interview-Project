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
        stage('terraform apply') {
            steps{
                sh 'ls -la'
                sh 'cd ./AWS/envs/'
                sh 'ls -ls'
                sh 'terraform plan  -var-file=\'./vars/dev.tfvars\' '
            }
        }
    }

    
}
