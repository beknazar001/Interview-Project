terraform {
  backend "s3" {
    bucket = "beknzar-saittegin-dev-bucket-1234"
    key    = "terraform/dev/network/terraform.tfstate"
    region = "us-east-1"
  }
}
