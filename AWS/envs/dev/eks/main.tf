provider "aws" {

  region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket = "beknzar-saittegin-dev-bucket-1234"
    key    = "terraform/dev/eks/terraform.tfstate"
    region = "us-east-1"
  }
}

module "eks" {
  source               = "../../../modules/eks"
  eks_name             = var.eks_name
  eks_version          = var.eks_version
  eks_endpoint         = var.eks_endpoint
  public_access        = var.public_access
  subnet_ids           = data.terraform_remote_state.subnet_ids.outputs.private_subnets[*]
  cluster_name         = var.cluster_name
  node_group_name      = var.node_group_name
  node_subnets         = data.terraform_remote_state.subnet_ids.outputs.public_subnets[*]
  desired_size         = var.desired_size
  max_size             = var.max_size
  min_size             = var.min_size
  ami_type             = var.ami_type
  capacity_type        = var.capacity_type
  disk_size            = var.disk_size
  force_update_version = var.force_update_version
  instance_types       = var.instance_types
  vpc_id               = data.terraform_remote_state.subnet_ids.outputs.vpc_id

  inbound_all = [{
    from_port   = var.inbound_from_port[0]
    to_port     = var.inbound_to_port[0]
    protocol    = var.inbound_protocol
    cidr_blocks = var.inbound_blocks
    },
    {
      from_port   = var.inbound_from_port[1]
      to_port     = var.inbound_to_port[1]
      protocol    = var.inbound_protocol
      cidr_blocks = var.inbound_blocks
    }
  ]


  outbound_all = [{
    from_port   = var.outbound_from_port[0]
    to_port     = var.outbound_to_port[0]
    protocol    = var.outbound_protocol
    cidr_blocks = var.outbound_blocks
  }]

  security_tags = {
    Name = var.security_group_tag
  }
}
data "terraform_remote_state" "subnet_ids" {
  backend = "s3"
  config = {
    region = "us-east-1"
    key    = "terraform/dev/network/terraform.tfstate"
    bucket = "beknzar-saittegin-dev-bucket-1234"
  }
}