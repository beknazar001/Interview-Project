terraform {
  backend "s3" {
    bucket = "<BUCKET_NAME>"
    key    = "terraform/prod"
    region = "us-east-1"
  }
}
