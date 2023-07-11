# network vars
vpc_cidr                    = "192.168.0.0/16"
public_cidrs                = ["192.168.1.0/24", "192.168.2.0/24"]
private_cidrs               = ["192.168.3.0/24", "192.168.4.0/24", "192.168.5.0/24", "192.168.6.0/24"]
azs                         = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
associate_public_ip_address = true
key_name                    = "for-bastion"
instance_type               = "t2.micro"
env                         = "dev"

# EKS vars
eks_name                = "eks"
eks_version             = "1.23"
endpoint_private_access = true
endpoint_public_access  = false
cluster_name            = "eks"
node_group_name         = "node_group"
desired_size            = 3
max_size                = 4
min_size                = 2
ami_type                = "AL2_x86_64"
capacity_type           = "ON_DEMAND"
disk_size               = 20
force_update_version    = false
instance_types          = ["t2.small"]
outbound_all = [{
  port        = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}]

security_group_tag = "test"

module "db" {
  source                = "https://github.com/beknazar001/rds-child-module.git"
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
    "env" = var.env
  }

  db_option_group_name = "postresql-option-group"
  description          = "postgresql-option-group"
  major_engine_version = "14"
  # options              = []

  subnet_group_name               = "postresql-subnet-group"
  subnet_group_description        = "postresql-subnet-group"
  vpc_id                          = data.aws_vpc.default.id
  subnet_ids                      = data.aws_subnet_ids.default.ids
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

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

provider "kubernetes" {
  host                   = var.kubernetes_host
  cluster_ca_certificate = var.kubernetes_cluster_ca_certificate
  token                  = var.kubernetes_token
}