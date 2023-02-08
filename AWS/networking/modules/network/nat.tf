##############################################
#############  NAT GATEWAY       #############
##############################################
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnets[0].id
}

resource "aws_eip" "nat_eip" {
  tags = {
    Name = "eip-for-${var.env}-nat"
  }
}
