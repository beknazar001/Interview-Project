module "networking" {
  source                      = "git::https://github.com/beknazar001/vpc_child_module.git"
  vpc_cidr_block              = var.vpc_cidr
  max_subnets                 = var.max_subnets
  public_cidrs                = var.public_cidrs
  private_cidrs               = var.private_cidrs
  azs                         = var.azs
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  env                         = var.env
}


