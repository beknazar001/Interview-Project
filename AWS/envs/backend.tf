 terraform {
 backend "s3" {
 bucket = "interview-project-dev-bucket-1234"
  key    = "terraform.tfstate"
 region = "us-east-1"
 dynamodb_table = "mydbtable"
 # Automatically copy the existing state to the new backend
    migrate = true
}
}
