module "networking" {
  source                      = "../../modules/network"
  vpc_cidr_block              = var.vpc_cidr
  max_subnets                 = var.max_subnets
  public_subnets              = var.public_sn_count
  private_subnets             = var.private_sn_count
  public_cidrs                = ["192.168.1.0/24", "192.168.2.0/24"]
  private_cidrs               = ["192.168.3.0/24", "192.168.4.0/24", "192.168.5.0/24", "192.168.6.0/24"]
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  env                         = "dev"
}

module "eks" {
  source               = "../../../../eks"
  eks_name             = var.eks_name
  eks_version          = var.eks_version
  eks_endpoint         = var.eks_endpoint
  public_access        = var.public_access
  subnet_ids           = module.networking.outputs.private_subnets.*.id
  cluster_name         = var.cluster_name
  node_group_name      = var.node_group_name
  node_subnets         = module.networking.outputs.private_subnets.*.id
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
  depends_on = [module.networking]
}