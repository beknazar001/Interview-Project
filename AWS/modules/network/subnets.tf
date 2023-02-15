data "aws_availability_zones" "available" {}

resource "random_shuffle" "az_list" {
  input        = data.aws_availability_zones.available.names
  result_count = var.max_subnets
}
##############################################
##########     Public subnets     ############
##############################################
resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_cidrs)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.public_cidrs, count.index)
  map_public_ip_on_launch = true
  availability_zone       = var.azs[count.index]
  tags = {
    Name                        = "${var.env}-public-subnet-${count.index + 1}"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}

##############################################
##########     Private subnets     ############
##############################################
resource "aws_subnet" "private_subnets" {
  count                   = length(var.private_cidrs)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.private_cidrs, count.index)
  map_public_ip_on_launch = false
  availability_zone       = var.azs[count.index]
  tags = {
    Name                        = "${var.env}-private-subnet-${count.index + 1}"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}
