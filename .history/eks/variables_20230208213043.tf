variable "eks_name" {}
variable "eks_version" {}
variable "eks_endpoint" {}
variable "public_access" {}
variable "subnet_ids" {}
variable "cluster_name" {}
variable "node_group_name" {}
variable "node_subnets" {}
variable "desired_size" {}
variable "max_size" {}
variable "min_size" {}
variable "ami_type" {}
variable "capacity_type" {}
variable "disk_size" {}
variable "force_update_version" {}
variable "instance_types" {}
variable "vpc_id" {}
variable "security_group_tag" {}
variable "inbound_all" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "outbound_all" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}