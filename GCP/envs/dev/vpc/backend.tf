terraform {
  backend "gcs" {
    bucket = "anntech-dev-terraform"
    prefix = "vpc/"
  }
}
