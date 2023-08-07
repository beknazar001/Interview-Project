 terraform {
 backend "s3" {
 bucket = "interview-project-dev-bucket-12345"
  key    = "terraform.tfstate"
 region = "us-east-1"
 dynamodb_table = "mydbtable"
}
}
