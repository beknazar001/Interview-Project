
locals {
  master_instance_name = var.random_instance_name ? "${var.name}-${random_id.suffix[0].hex}" : var.name

  ip_configuration_enabled = length(keys(var.ip_configuration)) > 0 ? true : false

  ip_configurations = {
    enabled  = var.ip_configuration
    disabled = {}
  }

  databases = { for db in var.additional_databases : db.name => db }
  users     = { for u in var.additional_users : u.name => u }
  iam_users = [for iu in var.iam_user_emails : {
    email         = iu,
    is_account_sa = trimsuffix(iu, "gserviceaccount.com") == iu ? false : true
  }]

  // HA method using REGIONAL availability_type requires point in time recovery to be enabled
  point_in_time_recovery_enabled = var.availability_type == "REGIONAL" ? lookup(var.backup_configuration, "point_in_time_recovery_enabled", true) : lookup(var.backup_configuration, "point_in_time_recovery_enabled", false)
  backups_enabled                = var.availability_type == "REGIONAL" ? lookup(var.backup_configuration, "enabled", true) : lookup(var.backup_configuration, "enabled", false)

  retained_backups = lookup(var.backup_configuration, "retained_backups", null)
  retention_unit   = lookup(var.backup_configuration, "retention_unit", null)

  replicas = {
    for x in var.read_replicas : "${var.name}-replica${var.read_replica_name_suffix}${x.name}" => x
  }
}
