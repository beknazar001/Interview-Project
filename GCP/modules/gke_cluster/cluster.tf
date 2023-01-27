data "google_client_config" "current" {}

data "google_container_engine_versions" "default" {
  location = var.location
}

resource "google_container_cluster" "gke" {
  name                     = var.cluster_name
  location                 = var.location
  project                  = var.project_id
  remove_default_node_pool = true
  initial_node_count       = 1
  min_master_version       = var.min_master_version
  network                  = var.network_name
  subnetwork               = var.subnet_name
  resource_labels          = var.cluster_resource_labels
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = ""
    services_ipv4_cidr_block = ""
  }
  dynamic "private_cluster_config" {
    for_each = var.enable_private_nodes ? [{
      enable_private_nodes    = var.enable_private_nodes
      enable_private_endpoint = var.enable_private_endpoint
      master_ipv4_cidr_block  = var.master_ipv4_cidr_block
    }] : []

    content {
      enable_private_endpoint = private_cluster_config.value.enable_private_endpoint
      enable_private_nodes    = private_cluster_config.value.enable_private_nodes
      master_ipv4_cidr_block  = private_cluster_config.value.master_ipv4_cidr_block
    }
  }
  // Use ABAC until official Kubernetes plugin supports RBAC.
  enable_legacy_abac = true

  // Enable Workload Identity
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}

provider "kubernetes" {
  host                   = google_container_cluster.gke.endpoint
  token                  = data.google_client_config.current.access_token
  client_certificate     = base64decode(google_container_cluster.gke.master_auth.0.client_certificate)
  client_key             = base64decode(google_container_cluster.gke.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(google_container_cluster.gke.master_auth.0.cluster_ca_certificate)
}
