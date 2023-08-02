 terraform {
   backend "s3" {
     bucket = "interview-project-dev-bucket-12345"
     key    = "Interview-Project/AWS/envs"
     region = "us-east-1"
   }
 }
