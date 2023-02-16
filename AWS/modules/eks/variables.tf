variable "eks_name" {
  type        = string
  description = "Name of the cluster."
}
variable "eks_version" {
  type        = string
  description = "Desired Kubernetes master version."
}
variable "endpoint_private_access" {
  type        = bool
  description = "Whether the Amazon EKS private API server endpoint is enabled."
}
variable "endpoint_public_access" {
  type        = bool
  description = "Whether the Amazon EKS public API server endpoint is enabled. "
}
variable "subnet_ids" {
  type        = list(any)
  description = "List of subnet IDs."
}
variable "cluster_name" {
  type        = string
  description = "Name of the EKS Cluster. "
}
variable "node_group_name" {
  type        = string
  description = "Name of the EKS Node Group. "
}
variable "node_subnets" {
  type        = list(any)
  description = "Identifiers of EC2 Subnets to associate with the EKS Node Group. These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME (where CLUSTER_NAME is replaced with the name of the EKS Cluster)."
}
variable "desired_size" {
  type        = number
  description = "Desired number of worker nodes."
}
variable "max_size" {
  type        = number
  description = "Maximum number of worker nodes."
}
variable "min_size" {
  type        = number
  description = "Minimum number of worker nodes."
}
variable "ami_type" {
  type        = string
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group. "
}
variable "capacity_type" {
  type        = string
  description = "Type of capacity associated with the EKS Node Group. "
}
variable "disk_size" {
  type        = number
  description = "Disk size in GiB for worker nodes."
}
variable "force_update_version" {
  type        = bool
  description = "Force version update if existing pods are unable to be drained due to a pod disruption budget issue."
}
variable "instance_types" {
  type        = list(any)
  description = "List of instance types associated with the EKS Node Group."
}
variable "vpc_id" {
  type        = string
  description = "VPC ID."
}
variable "security_tags" {
  description = "List of security group IDs for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane."
}
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