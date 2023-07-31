 terraform {
   backend "s3" {
     bucket = "interview-project-dev-bucket-1234"
     key    = "terraform/dev/"
     region = "us-east-1"
   }
 }
