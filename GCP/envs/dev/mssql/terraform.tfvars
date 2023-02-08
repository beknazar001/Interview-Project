name = "mssql-enterprise"
project_id = "anttech2"
database_version = "SQLSERVER_2019_ENTERPRISE"
tier = "db-custom-2-3840"
region = "us-central1"
zone = "us-central1-a"
availability_type = "REGIONAL"
read_replicas = [
    {
      name                  = "test"
      zone                  = "us-central1-c"
      availability_type     = "ZONAL"
      tier                  = "db-custom-2-7680"
      disk_autoresize       = null
      disk_autoresize_limit = null
      disk_size             = null
      disk_type             = "PD_SSD"
      user_labels           = { test = "mssql" }
      encryption_key_name   = null
      database_flags = []
      ip_configuration = ({
        allocated_ip_range = null
        authorized_networks = []
        ipv4_enabled        = true
        require_ssl         = false
        private_network = null
    })
    }
]