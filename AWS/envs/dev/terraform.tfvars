vpc_cidr                    = "192.168.0.0/16"
associate_public_ip_address = true
key_name                    = "for-bastion"
instance_type               = "t2.micro"
env                         = "dev"
# for EKS module
eks_name                = "eks"
eks_version             = "1.23"
endpoint_private_access = true
endpoint_public_access  = false
cluster_name            = "eks"
node_group_name         = "node_group"
desired_size            = 2
max_size                = 4
min_size                = 2
ami_type                = "AL2_x86_64"
capacity_type           = "ON_DEMAND"
disk_size               = 20
force_update_version    = false
instance_types          = ["t2.small"]
outbound_all = [{
  port        = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}]

security_group_tag = "test"