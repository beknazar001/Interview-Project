data "aws_ami" "default" {
  most_recent = "true" #(Optional) If more than one result is returned, use the most recent AMI.
  dynamic "filter" {
    for_each = var.ami_filter
    content {
      name   = filter.key
      values = filter.value
    }
  }
  owners = var.ami_owners
}
resource "aws_key_pair" "for-bastion" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDbJKzWR/gcXPKusf/v22TYqRIlCWZ50EzYzt7BXCCASRFvkmJPK9n6dZVChutjF9JuKgiBp4DgqDn/iaOADAHtqd/nz8kuBhTk0pLazFAQGveDnksyoKkj4o8DUsSF+DPvRgJjHxRGF7tjX08nXKCKlUOvnOQaLodHUoq6nxe4fDKoT6rD/fP3LskmfaRCuA9YJ+AXddXA5p0dfa+YbDjQHFwKJPywvxEHNQMmGBQC3YEf3MTIAlQfRFlRbpgSxNdwbfQ3TmC/G6qHwq1gsu/aysLKR1oevDrhb/eOxW8yXeYjoHghi0zhf1wl97s3wUJttnVjjtuLFp5pNRmcCgrF ec2-user@ip-192-168-1-254.ec2.internal"
}

resource "aws_instance" "bastion" {
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.bastion_host.id]
  ami                         = data.aws_ami.default.id
  iam_instance_profile        = aws_iam_instance_profile.bastion_instance_role.name
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = aws_key_pair.for-bastion.key_name
  subnet_id                   = aws_subnet.public_subnets[0].id
  monitoring                  = var.monitoring
  disable_api_termination     = var.disable_api_termination
  user_data                   = "${file("${path.module}/user_data.sh")}"
  metadata_options {
    http_endpoint               = (var.metadata_http_endpoint_enabled) ? "enabled" : "disabled"
    http_put_response_hop_limit = var.metadata_http_put_response_hop_limit
    http_tokens                 = (var.metadata_http_tokens_required) ? "required" : "optional"
  }

  root_block_device {
    encrypted   = var.root_block_device_encrypted
    volume_size = var.root_block_device_volume_size
  }

  # Optional block; skipped if var.ebs_block_device_volume_size is zero
  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device_volume_size > 0 ? [1] : []

    content {
      encrypted             = var.ebs_block_device_encrypted
      volume_size           = var.ebs_block_device_volume_size
      delete_on_termination = var.ebs_delete_on_termination
      device_name           = var.ebs_device_name
    }
  }

  tags = {
    Name = "${var.env}-bastion-host"
  }
}

resource "aws_eip" "default" {
  instance = aws_instance.bastion.id
  vpc      = true
  tags = {
    Name = "${var.env}-bastion-host-eip"
  }
}


locals {
  inbound_ports  = [22]
  outbound_ports = [0]
}
# Security Groups
resource "aws_security_group" "bastion_host" {
  vpc_id      = aws_vpc.vpc.id
  name        = "bastion-host-sg"
  description = "Security Group for the Bastion Host"
  dynamic "ingress" {
    for_each = local.inbound_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "egress" {
    for_each = local.outbound_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}


resource "aws_iam_role" "cluster" {
  name = "eks-cluster-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}

resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.cluster.name
}

# NODES
resource "aws_iam_role" "node" {
  name = "eks-node-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node.name
}

resource "aws_iam_instance_profile" "bastion_instance_role" {
  name = "eks-node-instance-profile"
  role = aws_iam_role.node.name
}






# resource "aws_iam_role" "instance_role" {
#   name               = "eks-cluster-bastion-role"
#   assume_role_policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# POLICY
# }

# resource "aws_iam_role_policy_attachment" "instance_role-AmazonEKSWorkerNodePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.instance_role.name
# }

# resource "aws_iam_role_policy_attachment" "instance_role-AmazonEKS_CNI_Policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.instance_role.name
# }

# resource "aws_iam_role_policy_attachment" "instance_role-AmazonEC2ContainerRegistryReadOnly" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.instance_role.name
# }

# resource "aws_iam_instance_profile" "bastion_instance_role" {
#   name = "eks-bastion_instance_role"
#   role = aws_iam_role.instance_role.name
# }


# IAM

# CLUSTER