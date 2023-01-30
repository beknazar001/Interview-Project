module "private-service-access" {
  source      = "../../../../GCP/modules/cloud_sql/private_access"
  project_id  = var.project_id
  vpc_network = "vpc"
}

module "mssql" {
  source              = "../../../../../GCP/modules/cloud_sql/mssql"
  name                = var.name
  project_id          = var.project_id
  database_version    = var.database_version
  user_name           = "simpleuser"
  user_password       = "foobar"
  deletion_protection = false
  tier                = var.tier
  region              = var.region
  availability_type   = var.availability_type
  zone                = var.zone
  read_replicas       = var.read_replicas
}
