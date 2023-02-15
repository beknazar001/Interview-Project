module "networking" {
  source         = "../../modules/network"
  vpc_cidr_block = var.vpc_cidr
  max_subnets    = var.max_subnets
  # public_subnets              = var.public_sn_count
  # private_subnets             = var.private_sn_count
  public_cidrs  = ["192.168.1.0/24", "192.168.2.0/24"]
  private_cidrs = ["192.168.3.0/24", "192.168.4.0/24", "192.168.5.0/24", "192.168.6.0/24"]
  azs           = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  # public_azs                  = ["us-east-1a", "us-east-1b"]
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  env                         = "dev"
}

module "eks" {
  source               = "../../modules/eks"
  eks_name             = var.eks_name
  eks_version          = var.eks_version
  eks_endpoint         = var.eks_endpoint
  public_access        = var.public_access
  subnet_ids           = [module.networking.private_subnets[0], module.networking.private_subnets[1]]
  cluster_name         = var.cluster_name
  node_group_name      = var.node_group_name
  node_subnets         = module.networking.private_subnets
  desired_size         = var.desired_size
  max_size             = var.max_size
  min_size             = var.min_size
  ami_type             = var.ami_type
  capacity_type        = var.capacity_type
  disk_size            = var.disk_size
  force_update_version = var.force_update_version
  instance_types       = var.instance_types
  vpc_id               = module.networking.vpc_id
  inbound_all          = var.inbound_all
  outbound_all         = var.outbound_all
  security_tags = {
    Name = var.security_group_tag
  }
}

#########################################################
###############       RDS Module           ##############
#########################################################

module "db" {
  source                 = "../../modules/aws_rds"
  identifier             = "demo"
  engine                 = "postgres"
  engine_version         = "14"
  instance_class         = "db.t3.micro"
  allocated_storage      = "20"
  max_allocated_storage  = "100"
  username               = "postgres"
  password               = "admin250800"
  port                   = "5432"
  vpc_security_group_ids = [""] #security groups
  multi_az               = false
  publicly_accessible    = false
  deletion_protection    = false

  tags = {
    "key" = "value"
  }

  db_option_group_name = "postresql-option-group"
  description          = "postgresql-option-group"
  major_engine_version = "14"
  options              = []

  subnet_group_name               = "postresql-subnet-group"
  subnet_group_description        = "postresql-subnet-group"
  subnet_ids                      = [module.networking.private_subnets[2], module.networking.private_subnets[3]]
  enabled_cloudwatch_logs_exports = ["upgrade"]
}
