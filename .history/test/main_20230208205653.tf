provider "aws" {
  access_key = "AKIARTLRXQNJAOOZTOT7"
  secret_key = "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"
  region     = "us-east-1"
}

module "eks" {
  source               = "../eks"
  eks_name             = var.eks_name
  eks_version          = var.eks_version
  eks_endpoint         = var.eks_endpoint
  public_access        = var.public_access
  subnet_ids           = ["subnet-03c8ab9d4159d5c00", "subnet-02458d5b9e37287a9"]
  cluster_name         = var.cluster_name
  node_group_name      = var.node_group_name
  node_subnets         = ["subnet-0706d6201042142e8", "subnet-0d2527ebfd17db762"]
  desired_size         = var.desired_size
  max_size             = var.max_size
  min_size             = var.min_size
  ami_type             = var.ami_type
  capacity_type        = var.capacity_type
  disk_size            = var.disk_size
  force_update_version = var.force_update_version
  instance_types       = var.instance_types
  vpc_id               = "vpc-0e65fca890dfac91e"

  inbound_all = [{
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]


  outbound_all = [{
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }]

  security_tags = {
    Name = "test"
  }
}