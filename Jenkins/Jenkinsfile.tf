// Jenkinsfile

@Library('mySharedLibrary') _

def devTfvarsPath = "path/to/dev.tfvars"
def devBackendPath = "path/to/dev/backend.tfvars"
def prodTfvarsPath = "path/to/prod.tfvars"
def prodBackendPath = "path/to/prod/backend.tfvars"

pipeline {
    agent any
    
    stages {
        stage('Dev - Terraform Init') {
            steps {
                script {
                    mySharedLibrary.runTerraformInit(devTfvarsPath, devBackendPath, "dev")
                }
            }
        }
        
        stage('Dev - Terraform Plan') {
            steps {
                script {
                    mySharedLibrary.runTerraformPlan(devTfvarsPath, devBackendPath, "dev")
                }
            }
        }
        
        stage('Dev - Terraform Validate') {
            steps {
                script {
                    mySharedLibrary.runTerraformValidate(devTfvarsPath, "dev")
                }
            }
        }
        
        stage('Dev - Terraform Apply') {
            steps {
                script {
                    mySharedLibrary.runTerraformApply(devTfvarsPath, devBackendPath, "dev")
                }
            }
        }
        
        stage('Production - Terraform Init') {
            steps {
                script {
                    mySharedLibrary.runTerraformInit(prodTfvarsPath, prodBackendPath, "prod")
                }
            }
        }
        
        stage('Production - Terraform Plan') {
            steps {
                script {
                    mySharedLibrary.runTerraformPlan(prodTfvarsPath, prodBackendPath, "prod")
                }
            }
        }
        
        stage('Production - Terraform Validate') {
            steps {
                script {
                    mySharedLibrary.runTerraformValidate(prodTfvarsPath, "prod")
                }
            }
        }
        
        stage('Production - Terraform Apply') {
            steps {
                script {
                    mySharedLibrary.runTerraformApply(prodTfvarsPath, prodBackendPath, "prod")
                }
            }
        }
    }
}
