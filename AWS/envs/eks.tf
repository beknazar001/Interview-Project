#########################################################
###############       EKS Module           ##############
#########################################################
module "eks" {
  # source                  = "git::https://github.com/beknazar001/eks-child-module.git"
  source="../modules/eks"
  eks_name                = var.eks_name
  eks_version             = var.eks_version
  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access  = var.endpoint_public_access
  subnet_ids              = [module.networking.private_subnets[0], module.networking.private_subnets[1]]
  cluster_name            = var.cluster_name
  node_group_name         = var.node_group_name
  node_subnets            = module.networking.private_subnets
  desired_size            = var.desired_size
  max_size                = var.max_size
  min_size                = var.min_size
  ami_type                = var.ami_type
  capacity_type           = var.capacity_type
  disk_size               = var.disk_size
  force_update_version    = var.force_update_version
  instance_types          = var.instance_types
  vpc_id                  = module.networking.vpc_id
  inbound_all = [
    {
      port        = 443
      protocol    = "tcp"
      cidr_blocks = ["${module.networking.bastion_internal_ip}/32"] # you have to update this part after completion to the ec2 private ip
    },
    {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = ["${module.networking.bastion_internal_ip}/32"] # you have to update this part after completion to the ec2 private ip

    }
  ]

  outbound_all = var.outbound_all
  security_tags = {
    Name = var.security_group_tag
  }
}
