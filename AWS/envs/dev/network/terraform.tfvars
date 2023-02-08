vpc_cidr                    = "192.168.0.0/16"
public_sn_count             = 2
private_sn_count            = 2
associate_public_ip_address = true
key_name                    = "for-bastion"
instance_type               = "t2.micro"
env                         = "dev"
