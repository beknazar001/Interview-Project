 terraform {
   backend "s3" {
     bucket = "interview-project-dev-bucket-12345"
     key    = "Interview-Project/AWS/envs/vars"
     region = "us-east-1"
   }
 }
