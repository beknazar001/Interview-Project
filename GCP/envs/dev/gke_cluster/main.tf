######################################
############ GKE CLUSTER #############
######################################
data "google_project" "project" {
  project_id = var.gcp_project_id
}

data "google_compute_subnetwork" "dev_subnetwork" {
  project = var.gcp_project_id
  name    = var.subnetwork_name
  region  = var.subnetwork_region
}

module "gke_cluster" {
  source                  = "../../../modules/gke_cluster"
  cluster_name            = var.gke_cluster_name
  network_name            = data.google_compute_subnetwork.dev_subnetwork.network
  subnet_name             = data.google_compute_subnetwork.dev_subnetwork.name
  project_id              = var.gcp_project_id
  region                  = var.gcp_region
  location                = var.location
  node_pools              = var.node_pools
  enable_private_nodes    = var.enable_private_nodes
  master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  enable_private_endpoint = var.enable_private_endpoint
  cluster_resource_labels = { "mesh_id" : "proj-${data.google_project.project.number}" }
  min_master_version      = "1.25.4-gke.2100"
}
