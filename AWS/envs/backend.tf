 terraform {
   backend "s3" {
     bucket = "interview-project-dev-bucket-1234"
     key    = "Interview-Project/AWS/envs/vars"
     region = "us-east-1"
   }
 }
