project_id            = "anttech2"                
region                = "us-central1"
main_zone             = "us-central1-b"
subnets = [
    {
      subnet_name     = "presentation-subnet"
      subnet_ip_range = "10.100.0.0/16"
      subnet_region   = "us-central1"
    },
    {
      subnet_name           = "application-subnet"
      subnet_ip_range       = "10.101.0.0/16"
      subnet_region         = "us-central1"
      subnet_private_access = true
    },
    {
      subnet_name           = "database-subnet"
      subnet_ip_range       = "10.102.0.0/16"
      subnet_region         = "us-central1"
      subnet_private_access = true
    },
  ]

firewall_rules = [
    {
      name        = "presentation-firewall-rule"
      direction   = "INGRESS"
      ranges      = ["0.0.0.0/0"]
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
      ranges      = ["10.100.0.0/16"]
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
      ranges      = ["10.101.0.0/16"]
      source_tags = null
      target_tags = ["database"]

      allow = [{
        protocol = "all"
        ports    = null
      }]
      deny = []
    }
  ]
#========================== ROUTERS ==================================
  routes = [
    {
      name              = "igw-route"
      destination_range = "0.0.0.0/0"
      next_hop_internet = "true"
    },
  ]

  vpc_name = "vpc1"