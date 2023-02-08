data "aws_availability_zones" "available" {}

resource "random_shuffle" "az_list" {
  input        = data.aws_availability_zones.available.names
  result_count = var.max_subnets
}
##############################################
##########     Public subnets     ############
##############################################
resource "aws_subnet" "public_subnets" {
  count                   = var.public_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone       = random_shuffle.az_list.result[count.index]
  tags = {
    Name = "${var.env}-public-subnet-${count.index + 1}"
  }
}

##############################################
##########     Private subnets     ############
##############################################
resource "aws_subnet" "private_subnets" {
  count                   = var.private_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone       = random_shuffle.az_list.result[count.index]
  tags = {
    Name = "${var.env}-private-subnet-${count.index + 1}"
  }
}
