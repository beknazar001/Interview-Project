provider "aws" {
  access_key = "AKIARPZR2Z7VCPAUWUG5"
  secret_key = "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"
  region     = "us-east-1"
}

module "eks" {
  source               = "../eks"
  eks_name             = "eks"
  eks_version          = "1.23"
  eks_endpoint         = false
  public_access        = true
  subnet_ids           = ["subnet-03775f56e1a6fb992", "subnet-01f6a65f11bd0c78b"]
  cluster_name         = "eks"
  node_group_name      = "node_group"
  node_subnets         = ["subnet-0b0937eae0754cd44", "subnet-0f36416efa5c186c8"]
  desired_size         = 2
  max_size             = 4
  min_size             = 2
  ami_type             = "AL2_x86_64"
  capacity_type        = "ON_DEMAND"
  disk_size            = 20
  force_update_version = false
  instance_types       = ["t3.small"]
}