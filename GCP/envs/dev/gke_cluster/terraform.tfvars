gcp_project_id = "anttech2"
gcp_region = "us-central1"

#############Existing subnetwork#############
subnetwork_name = "application-subnet"
subnetwork_region = "us-central1"

######################################
############ GKE CLUSTER #############
######################################
gke_cluster_name        = "anttech-dev-cluster"
location                = "us-central1-a"
enable_private_nodes    = true
enable_private_endpoint = false
master_ipv4_cidr_block  = "172.16.0.0/28"
#############Node pool#############
node_pools = {
  node-pool = {
    location           = "us-central1-a"
    node_locations     = ["us-central1-a"]
    machine_type       = "e2-medium"
    initial_node_count = 3
  }
}