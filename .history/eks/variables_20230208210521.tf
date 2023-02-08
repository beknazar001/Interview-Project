variable "eks_name" {
    description = "value"
    default = ""
}
variable "eks_version" {
    description = "value"
    default = ""
}
variable "eks_endpoint" {
    description = "value"
    default = ""
}
variable "public_access" {
    description = "value"
    default = ""
}
variable "subnet_ids" {
    description = "value"
    default = ""
}
variable "cluster_name" {
    description = "value"
    default = ""
}
variable "node_group_name" {
    description = "value"
    default = ""
}
variable "node_subnets" {
    description = "value"
    default = ""
}
variable "desired_size" {
    description = "value"
    default = ""
}
variable "max_size" {
    description = "value"
    default = ""
}
variable "min_size" {
    description = "value"
    default = ""
}
variable "ami_type" {
    description = "value"
    default = ""
}
variable "capacity_type" {
    description = "value"
    default = ""
}
variable "disk_size" {
    description = "value"
    default = ""
}
variable "force_update_version" {
    description = "value"
    default = ""
}
variable "instance_types" {
    description = "value"
    default = ""
}
variable "vpc_id" {
    description = "value"
    default = ""
}
variable "security_tags" {
    description = "value"
    default = ""
}
variable "inbound_all" {
    description = "value"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "outbound_all" {
    description = "value"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}