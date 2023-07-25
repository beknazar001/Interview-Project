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
                sh 'cd ./AWS/envs/'
                sh 'terraform init'
            }
        }
        stage('terraform apply') {
            steps{
                sh 'cd ./AWS/envs/'
                sh 'terraform plan  -var-file=\'/vars/stage.tfvars\' '
            }
        }
    }

    
}
