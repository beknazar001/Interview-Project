provider "aws" {
  access_key = "AKIARPZR2Z7VCPAUWUG5"
  secret_key = "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"
  region     = "us-east-1"
}

module "eks" {
  source               = "../eks"
  eks_name             = "eks"
  eks_version          = "1.18"
  eks_endpoint         = false
  public_access        = true
  subnet_ids           = "sdfs"
  node_node_group_name = "node_group"
  node_subnets = 
  desired_size         = 2
  max_size             = 4
  min_size             = 2
  ami_type             = "AL2_x86_64"
  capacity_type        = "ON_DEMAND"
  disk_size            = 20
  force_update_version = false
  instance_types       = ["t3.small"]
}