data "aws_ami" "default" {
  most_recent = "true"
  dynamic "filter" {
    for_each = var.ami_filter
    content {
      name   = filter.key
      values = filter.value
    }
  }
  owners = var.ami_owners
}


resource "aws_instance" "default" {
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.bastion_host.id]
  ami                    = data.aws_ami.default.id
  #   iam_instance_profile        = local.instance_profile
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.public_subnets[0].id
  monitoring                  = var.monitoring
  disable_api_termination     = var.disable_api_termination

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
  instance = aws_instance.default.id
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
