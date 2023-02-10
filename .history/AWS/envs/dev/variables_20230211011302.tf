variable "vpc_cidr" {
  type = string
}

variable "public_sn_count" {
  type = number
}

variable "private_sn_count" {
  type = number
}

variable "max_subnets" {
  type    = number
  default = 20
}

variable "associate_public_ip_address" {
  type        = bool
  default     = false
  description = "Whether to associate a public IP to the instance."
}

variable "key_name" {
  type        = string
  default     = ""
  description = "Key name"
}
variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Bastion instance type"
}

variable "env" {
  type        = string
  description = "The name of environment: dev, stage, prod"
}

variable "eks_name" {}
variable "eks_version" {}
variable "eks_endpoint" {}
variable "public_access" {}
variable "cluster_name" {}
variable "node_group_name" {}
variable "desired_size" {}
variable "max_size" {}
variable "min_size" {}
variable "ami_type" {}
variable "capacity_type" {}
variable "disk_size" {}
variable "force_update_version" {}
variable "instance_types" {}
variable "security_group_tag" {}
variable "inbound_all" {
  type = list(object({
    # from_port   = number
    port        = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
variable "outbound_all" {
  type = list(object({
    port = number
    # to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
