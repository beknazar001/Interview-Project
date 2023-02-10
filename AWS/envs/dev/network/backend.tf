terraform {
  backend "s3" {
    bucket = "tfstate-tfsate-tfstate"
    key    = "terraform/dev"
    region = "us-east-1"
  }
}
