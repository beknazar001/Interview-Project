module "google_networks" {
  source = "../../../modules/gcp_vpc"

  nat_subnet_name = "application-subnet"

  #==========================SUBNETS=============================
  subnets = [
    {
      subnet_name     = "presentation-subnet"
      subnet_ip_range = var.presentation_ip_range
      subnet_region   = "us-central1"
    },
    {
      subnet_name           = "application-subnet"
      subnet_ip_range       = var.application_ip_range
      subnet_region         = "us-central1"
      subnet_private_access = true
    },
    {
      subnet_name           = "database-subnet"
      subnet_ip_range       = var.database_ip_range
      subnet_region         = "us-central1"
      subnet_private_access = true
    },

  ]


  #============================ROUTES=============================

  routes = [
    {
      name              = "igw-route"
      destination_range = var.igw_destination
      next_hop_internet = "true"
    },
  ]

  #=========================FIREWALL-RULES========================
  firewall_rules = [
    {
      name        = "presentation-firewall-rule"
      direction   = "INGRESS"
      ranges      = var.presentation_firewall_ranges
      target_tags = ["public"]
      source_tags = null

      allow = [{
        protocol = "tcp"
        ports    = ["22"]
      }]
      deny = []
    },
    {
      name        = "application-db-firewall-rule"
      direction   = "INGRESS"
      ranges      = var.application_firewall_ranges
      target_tags = ["application", "database"]
      source_tags = null

      allow = [{
        protocol = "all"
        ports    = null
      }]
      deny = []

    },
    {
      name        = "database-firewall-rule"
      direction   = "INGRESS"
      ranges      = var.database_firewall_ranges
      source_tags = null
      target_tags = ["database"]

      allow = [{
        protocol = "all"
        ports    = null
      }]
      deny = []
    }
  ]
}
