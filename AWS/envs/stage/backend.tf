terraform {
  backend "s3" {
    bucket = "<BUCKET_NAME>"
    key    = "terraform/stage"
    region = "us-east-1"
  }
}
