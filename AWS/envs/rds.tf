#########################################################
###############       RDS Module           ##############
#########################################################
# module "db" {
#   source                = "../../modules/aws_rds"
#   identifier            = "demo"
#   engine                = "postgres"
#   engine_version        = "14"
#   instance_class        = "db.t3.micro"
#   allocated_storage     = "20"
#   max_allocated_storage = "100"
#   username              = "postgres"
#   password              = "postgres"
#   port                  = "5432"
#   multi_az              = false
#   publicly_accessible   = false
#   deletion_protection   = false

  # tags = {
  #   "env" = "${var.env}"
  # }

#   db_option_group_name = "postresql-option-group"
#   description          = "postgresql-option-group"
#   major_engine_version = "14"
#   # options              = []

  # subnet_group_name               = "postresql-subnet-group"
  # subnet_group_description        = "postresql-subnet-group"
  # vpc_id                          = module.networking.vpc_id
  # subnet_ids                      = [module.networking.private_subnets[2], module.networking.private_subnets[3]]
#   enabled_cloudwatch_logs_exports = ["upgrade"]
#   rds_inbound = [
#     {
#       port        = 5432
#       protocol    = "tcp"
#       cidr_blocks = ["${module.networking.bastion_internal_ip}/32"]
#     },
#     {
#       port        = 22
#       protocol    = "tcp"
#       cidr_blocks = ["${module.networking.bastion_internal_ip}/32"]

#     }
#     ,
#     {
#       port        = 0
#       protocol    = "all"
#       cidr_blocks = ["192.168.0.0/16"]

#     }
#   ]

#   rds_outbound = var.outbound_all
#   security_tags = {
#     Name = var.security_group_tag
#   }
# }

provider "kubernetes" {
  host                   = module.eks.endpoint
  cluster_ca_certificate = module.eks.cacert
  token                  = module.eks.token
}

module "db" {
  source                = "git::https://github.com/beknazar001/rds-child-module.git"
  identifier            = var.identifier
  engine                = var.engine
  engine_version        = var.engine_version
  instance_class        = var.instance_class
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  username              = var.username
  password              = var.password
  port                  = var.port
  multi_az              = var.multi_az
  publicly_accessible   = var.publicly_accessible
  deletion_protection   = var.deletion_protection

   tags = {
    "env" = "${var.env}"
  }

  db_option_group_name = "postresql-option-group"
  description          = "postgresql-option-group"
  major_engine_version = "14"
  # options              = []

  subnet_group_name               = "postresql-subnet-group"
  subnet_group_description        = "postresql-subnet-group"
  vpc_id                          = module.networking.vpc_id
  subnet_ids                      = [module.networking.private_subnets[2], module.networking.private_subnets[3]]
  enabled_cloudwatch_logs_exports = ["upgrade"]
  rds_inbound = [
    {
      port        = 5432
      protocol    = "tcp"
      cidr_blocks = ["${module.networking.bastion_internal_ip}/32"]
    },
    {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = ["${module.networking.bastion_internal_ip}/32"]
    },
    {
      port        = 0
      protocol    = "all"
      cidr_blocks = ["192.168.0.0/16"]
    }
  ]

  rds_outbound = var.outbound_all
  security_tags = {
    Name = var.security_group_tag
  }
}


