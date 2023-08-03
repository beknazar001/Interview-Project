


 pipeline {
    agent any

    parameters {
      
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
        booleanParam(name: 'destroy', defaultValue: false, description: 'Destroy Terraform build?')
        string(name: 'tfVarFile', defaultValue: './vars/dev.tfvars', description: 'Terraform variable file path') 
    }


     environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }


    stages {

        stage('Plan') {
            when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            
            steps {
                sh """
                 cd ./AWS/envs/
                 terraform init -backend-config="bucket=interview-project-dev-bucket-12345" 
                 ls -la
                 terraform plan -input=false -out tfplan -var-file=${params.tfVarFile}
                 ls -la
                 terraform show -no-color tfplan > tfplan.txt
             """
                
            }
        }
     stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
               not {
                    equals expected: true, actual: params.destroy
                }
           }
           
                
            

           steps {
               script {
                   
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }

           
                
            

          

        stage('Apply') {
            when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            
            steps {
                sh  '''cd ./AWS/envs/
                terraform apply tfplan'''
               
            }
        }
        
        stage('Destroy') {
            when {
                   equals expected: true, actual: params.destroy
              }
        
        steps {
           sh '''cd ./AWS/envs/
           ls -la
           terraform destroy -var-file=${params.tfVarFile} --auto-approve'''
        }
    }

  }

 }

    



   
