
    pipeline 

    agent any{


     environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
            
            steps {
                sh '''ls -la
                cd ./AWS/envs/
                 terraform init'''
                sh '${environment}'
            }
        
            
            steps {
                sh '''ls -la
                cd ./AWS/envs/
                terraform plan'''
                sh 'terraform plan  -var-file=./vars/dev.tfvars'
            }
        
        
         steps {
            sh '''ls -la
                cd ./AWS/envs/
                terraform destroy'''
             sh 'terraform destroy --auto-approve'
        }
    }
    



    

