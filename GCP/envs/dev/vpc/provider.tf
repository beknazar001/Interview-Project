terraform {
  backend "gcs" {
    bucket = "anntech-dev-terraform"
    prefix = "vpc/"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.53.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file_path)
  project     = var.project_id
}
