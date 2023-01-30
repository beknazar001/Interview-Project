terraform {
  backend "gcs" {
    bucket = "anntech-dev-terraform"
    prefix = "gke_cluster/"
  }
}
