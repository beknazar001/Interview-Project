module "networking" {
  source                      = "../../../modules/network"
  vpc_cidr_block              = var.vpc_cidr
  max_subnets                 = var.max_subnets
  public_subnets              = var.public_sn_count
  private_subnets             = var.private_sn_count
  public_cidrs                = ["192.168.1.0/24", "192.168.2.0/24"]
  private_cidrs               = ["192.168.3.0/24", "192.168.4.0/24"]
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  env                         = "dev"
}

