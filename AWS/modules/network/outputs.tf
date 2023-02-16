output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnets" {
  value = aws_subnet.public_subnets.*.id
}

output "private_subnets" {
  value = aws_subnet.private_subnets.*.id
}
output "bastion_internal_ip" {
  description = "bastion private ip"
  value       = aws_instance.bastion.private_ip
}
