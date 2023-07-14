// mySharedLibrary.groovy

def runTerraformInit(tfvarsPath, backendPath, stage) {
    sh "terraform init -backend-config=${backendPath} ${tfvarsPath}"
        sh "terraform workspace new ${stage}"
	    sh "terraform workspace select ${stage}"
	    }

	    def runTerraformPlan(tfvarsPath, backendPath, stage) {
	        sh "terraform plan -var-file=${tfvarsPath} -backend-config=${backendPath} -var='stage=${stage}'"
		}

		def runTerraformValidate(tfvarsPath, stage) {
		    sh "terraform validate -var-file=${tfvarsPath} -var='stage=${stage}'"
		    }

		    def runTerraformApply(tfvarsPath, backendPath, stage) {
		        sh "terraform apply -var-file=${tfvarsPath} -backend-config=${backendPath} -auto-approve -var='stage=${stage}'"
			}
