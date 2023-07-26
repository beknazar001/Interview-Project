
  pipeline {
    agent any
    tools {
       terraform 'terraform'
    }
    stages {

        stage('terraform format check') {
            steps{
                sh '''ls -la
                 cd ./AWS/envs/
                 terraform fmt'''
            }
        }
        stage('terraform Init') {
            steps{
                sh '''ls -la
                cd ./AWS/envs/
                terraform init'''
            }
        }
        stage('terraform plan') {
            steps{
                sh '''ls -la
                cd ./AWS/envs/
                ls -la
                terraform plan  -var-file=./vars/dev.tfvars'''
            }
        }
    }
    



    

