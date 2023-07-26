// pipeline {
//     agent any
//     tools {
//        terraform 'terraform'
//     }
//     stages {

//         stage('terraform format check') {
//             steps{
//                 sh '''ls -la
//                  cd ./AWS/envs/
//                  terraform fmt'''
//             }
//         }
//         stage('terraform Init') {
//             steps{
//                 sh '''ls -la
//                 cd ./AWS/envs/
//                 terraform init'''
//             }
//         }
//         stage('terraform plan') {
//             steps{
//                 sh '''ls -la
//                 cd ./AWS/envs/
//                 ls -la
//                 terraform plan  -var-file=./vars/dev.tfvars'''
//             }
//         }
//     }



    pipeline {
    agent any

    parameters {
        string(name: 'environment', defaultValue: 'terraform', description: 'Workspace/environment file to use for deployment')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
        booleanParam(name: 'destroy', defaultValue: false, description: 'Destroy Terraform build?')

    }


     environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }


    stages {
        stage('checkout') {
            steps {
                 
                        {
                            git "https://github.com/beknazar001/Interview-Project.git"
                        }
                    }
                }
            }
            
            steps {
                sh 'ls -la cd ./AWS/envs/'
                sh 'terraform init -input=false'
                sh 'terraform workspace select ${environment} || terraform workspace new ${environment}'
                sh 'terraform plan  -var-file=./vars/dev.tfvars'
            }
        }
            
            steps {
                sh '''ls -la
                cd ./AWS/envs/
                terraform apply'''
                sh "terraform plan  -var-file=./vars/dev.tfvars"
            }
        }
        
        
         steps {
            sh '''ls -la
                cd ./AWS/envs/
                terraform destroy'''
             sh "terraform destroy --auto-approve"
        }
    }

  }
}

    

