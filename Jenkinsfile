
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
                sh '''ls -la
                cd ./AWS/envs/
                 terraform init'''
                sh '${environment}'
            }
        }
            
            steps {
                sh '''ls -la
                cd ./AWS/envs/
                terraform plan'''
                sh 'terraform plan  -var-file=./vars/dev.tfvars'
            }
        }
        
        
         steps {
            sh '''ls -la
                cd ./AWS/envs/
                terraform destroy'''
             sh 'terraform destroy --auto-approve'
        }
    }

  }
}

    

