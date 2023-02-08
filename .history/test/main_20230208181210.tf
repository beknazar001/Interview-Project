provider "aws" {
  access_key = "AKIARTLRXQNJAOOZTOT7"
  secret_key = "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"
  region     = "us-east-1"
}

module "eks" {
  source               = "../eks"
  eks_name             = "eks"
  eks_version          = "1.23"
  eks_endpoint         = false
  public_access        = true
  subnet_ids           = ["subnet-078533c8fcb8d78de", "	subnet-0c731aca72530dd35"]
  cluster_name         = "eks"
  node_group_name      = "node_group"
  node_subnets         = ["subnet-004a73b5e0150b116", "subnet-09c836f9b9c847745"]
  desired_size         = 2
  max_size             = 4
  min_size             = 2
  ami_type             = "AL2_x86_64"
  capacity_type        = "ON_DEMAND"
  disk_size            = 20
  force_update_version = false
  instance_types       = ["t3.small"]
}