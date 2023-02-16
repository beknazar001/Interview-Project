module "networking" {
  source                      = "../../modules/network"
  vpc_cidr_block              = "192.168.0.0/16"
  max_subnets                 = 20
  public_cidrs                = ["192.168.1.0/24", "192.168.2.0/24"]
  private_cidrs               = ["192.168.3.0/24", "192.168.4.0/24", "192.168.5.0/24", "192.168.6.0/24"]
  azs                         = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  env                         = "dev"
}





module "eks" {
  source                  = "../../modules/eks"
  eks_name                = "eks"
  eks_version             = "1.23"
  subnet_ids              = [module.networking.private_subnets[0], module.networking.private_subnets[1]]
  cluster_name            = "eks"
  node_group_name         = "node_group"
  node_subnets            = module.networking.private_subnets
  desired_size            = 3
  max_size                = 4
  min_size                = 2
  ami_type                = "AL2_x86_64"
  capacity_type           = "ON_DEMAND"
  disk_size               = 20
  force_update_version    = false
  instance_types          = ["t2.small"]
  vpc_id                  = module.networking.vpc_id
  inbound_all = [
    {
      port = 443
      # to_port     = [443]
      protocol    = "tcp"
      cidr_blocks = ["${module.networking.bastion_internal_ip}/32"] # you have to update this part after completion to the ec2 private ip
    },
    {
      port = 22
      # to_port     = [443]
      protocol    = "tcp"
      cidr_blocks = ["${module.networking.bastion_internal_ip}/32"] # you have to update this part after completion to the ec2 private ip

    }
  ]

  outbound_all = [{
  port        = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}]
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

provider "kubernetes" {
  host                   = module.eks.endpoint
  cluster_ca_certificate = module.eks.cacert
  token                  = module.eks.token
}



