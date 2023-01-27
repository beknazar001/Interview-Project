variable "cluster_name" {
  type        = string
  description = "The name of the cluster (required)"
}
variable "network_name" {
  type        = string
  description = "The VPC network to host the cluster in (required)"
}
variable "subnet_name" {
  type        = string
  description = "The subnetwork to host the cluster in (required)"
}
variable "project_id" {
  type        = string
  description = "The project ID to host the cluster in (required)"
}
variable "region" {
  description = "The region to host the cluster in"
}
variable "location" {}
variable "enable_private_nodes" {
  type        = bool
  description = "(Beta) Whether nodes have internal IP addresses only"
}
variable "master_ipv4_cidr_block" {
  type        = string
  description = "(Beta) The IP range in CIDR notation to use for the hosted master network"
}
variable "enable_private_endpoint" {
  type        = bool
  description = "(Beta) Whether the master's internal IP address is used as the cluster endpoint"
}
variable "cluster_resource_labels" {}


variable "port_name" {
  default = "http"
}
variable "node_pools" {
  description = "List of maps containing node pools"
}

variable "min_master_version" {

}
