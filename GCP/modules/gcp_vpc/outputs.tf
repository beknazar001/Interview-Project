output "vpc_name" {
  value = google_compute_network.vpc.name
}

output "subnet_name" {
  value = [for subnet in google_compute_subnetwork.subnets : subnet.name]
}

# output "subnet_region" {
#   value = [for subnet in google_compute_subnetwork.subnets : subnet.region]
# }

