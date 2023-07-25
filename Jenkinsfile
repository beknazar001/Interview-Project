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
                withCredentials([usernamePassword(credentialsId: 'nurbolot01', passwordVariable: 'GIT_PASS', usernameVariable: 'GIT_USER')]) {
  sh "git config --global credential.helper '!f() { sleep 1; echo \"username=${env.GIT_USER}\\npassword=${env.GIT_PASS}\"; }; f'"
  sh 'terraform init -input=false -upgrade'
  sh 'git config --global --remove-section credential'
}
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

    
}
