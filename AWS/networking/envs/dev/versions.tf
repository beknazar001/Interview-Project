terraform {
  # backend "s3" {
  #   bucket = "bucket-name"
  #   key    = "terraform/dev/"
  #   region = "us-east-1"
  # }
  required_providers {
    aws = {
      version = ">= 4.44.0"
      source  = "hashicorp/aws"
    }
  }
}
