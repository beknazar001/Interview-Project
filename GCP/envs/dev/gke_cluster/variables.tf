variable "gcp_project_id" {}
variable "gcp_region" {}

variable "subnetwork_name" {}
variable "subnetwork_region" {}

######################################
############ GKE CLUSTER #############
######################################
variable "gke_cluster_name" {
  type        = string
  description = "The name of the cluster (required)"
}

variable "location" {
  type        = string
  description = ""
}

variable "node_pools" {
  description = "List of maps containing node pools"
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "(Beta) The IP range in CIDR notation to use for the hosted master network"
}

variable "enable_private_endpoint" {
  type        = bool
  description = "(Beta) Whether the master's internal IP address is used as the cluster endpoint"
}

variable "enable_private_nodes" {
  type        = bool
  description = "(Beta) Whether nodes have internal IP addresses only"
}