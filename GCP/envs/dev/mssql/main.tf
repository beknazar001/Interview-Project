module "mssql" {
  source              = "../../child-module/mssql"
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
  databases           = var.databases
}


variable "databases" {
  description = "databases to be created in the master instance"
  type = list(object({
    collation = string
    charset   = string
    name      = string
  }))
}
