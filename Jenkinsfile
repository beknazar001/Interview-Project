pipeline {
    agent any
    tools {
       terraform 'terraform'
    }
    stages {

        stage('terraform format check') {
            steps{
                sh 'ls -la'
                sh 'cd /Interview-Project/AWS/envs/'
                sh 'terraform fmt'
            }
        }
        stage('terraform Init') {
            steps{
                sh 'cd /Interview-Project/AWS/envs/'
                sh 'terraform init'
            }
        }
        stage('terraform apply') {
            steps{
                sh 'cd /Interview-Project/AWS/envs/'
                sh 'terraform plan --auto-approve -var-file=\'vars/dev.tfvars\' '
            }
        }
    }
}
