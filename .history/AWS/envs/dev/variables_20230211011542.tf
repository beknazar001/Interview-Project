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

variable "eks_name" {
    description = "Name of the cluster."
}
variable "eks_version" {
    description = "Desired Kubernetes master version."
}
variable "eks_endpoint" {
    description = "Whether the Amazon EKS private API server endpoint is enabled."
}
variable "public_access" {
    description = "Whether the Amazon EKS public API server endpoint is enabled. "
}
variable "cluster_name" {
    description = "Name of the EKS Cluster. "
}
variable "node_group_name" {
    description = "Name of the EKS Node Group. "
}
variable "desired_size" {
    description = "Desired number of worker nodes."
}
variable "max_size" {
    description = "Maximum number of worker nodes."
}
variable "min_size" {
    description = "Minimum number of worker nodes."
}
variable "ami_type" {
    description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group. "
}
variable "capacity_type" {
    description = "Type of capacity associated with the EKS Node Group. "
}
variable "disk_size" {
    description = "Disk size in GiB for worker nodes."
}
variable "force_update_version" {
    description = "Force version update if existing pods are unable to be drained due to a pod disruption budget issue."
}
variable "instance_types" {
    description = "List of instance types associated with the EKS Node Group."
}
variable "security_group_tag" {
    description = "List of security group IDs for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane."
}
variable "inbound_from_port" {
    description = "Start port (or ICMP type number if protocol is icmp or icmpv6)."
}
variable "inbound_to_port" {
    description = "End range port (or ICMP code if protocol is icmp)."
}
variable "inbound_protocol" {
    description = "Protocol."
}
variable "inbound_blocks" {
    description = " List of CIDR blocks."
}
variable "outbound_from_port" {
    description = "Start port (or ICMP type number if protocol is icmp)"
}
variable "outbound_to_port" {
    description = "End range port (or ICMP code if protocol is icmp)."
}
variable "outbound_protocol" {
    description = "List of CIDR blocks."
}
variable "outbound_blocks" {
    description = "Protocol."
}
