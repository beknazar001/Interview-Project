resource "aws_db_instance" "ms-sqll" {
  identifier                            = var.identifier
  engine                                = var.engine
  engine_version                        = var.engine_version
  instance_class                        = var.instance_class
  allocated_storage                     = var.allocated_storage
  max_allocated_storage                 = var.max_allocated_storage
  username                              = var.username
  password                              = var.password
  port                                  = var.port
  iam_database_authentication_enabled   = var.iam_database_authentication_enabled
  vpc_security_group_ids                = [aws_security_group.rds_sg.id]
  db_subnet_group_name                  = aws_db_subnet_group.db_sg.id
  parameter_group_name                  = var.parameter_group_name
  option_group_name                     = aws_db_option_group.db_opt_gr.name
  storage_encrypted                     = true
  license_model                         = "postgresql-license"
  availability_zone                     = var.availability_zone
  multi_az                              = var.multi_az
  publicly_accessible                   = var.publicly_accessible
  allow_major_version_upgrade           = var.allow_major_version_upgrade
  backup_retention_period               = var.backup_retention_period
  backup_window                         = var.backup_window
  timezone                              = var.timezone
  enabled_cloudwatch_logs_exports       = var.enabled_cloudwatch_logs_exports
  deletion_protection                   = var.deletion_protection
  tags                                  = var.tags
  skip_final_snapshot                   = var.skip_final_snapshot
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null
  performance_insights_kms_key_id       = var.performance_insights_enabled ? var.performance_insights_kms_key_id : null

  timeouts {
    create = lookup(var.timeouts, "create", null)
    delete = lookup(var.timeouts, "delete", null)
    update = lookup(var.timeouts, "update", null)
  }
}
