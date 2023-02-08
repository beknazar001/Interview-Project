module "google_networks" {
  source          = "../../../modules/gcp_vpc"
  nat_subnet_name = "application-subnet"
  #==========================SUBNETS=============================
  subnets = var.subnets
  #============================ROUTES=============================
  routes = var.routes
  #=========================FIREWALL-RULES========================
  firewall_rules = var.firewall_rules
}
