#========================== vpc.tf/variables =============================
variable "vpc_cidr_block" {
  description = "cidr range of the VPC"
  type        = string
}
#======================== subnets.tf/variables ===========================
variable "max_subnets" {
  type = number
}

variable "azs" {}

variable "public_cidrs" {
  description = "The cidr range of the public subnet"
}


variable "private_cidrs" {
  description = "The cidr range of the public subnet"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Bastion instance type"
}

variable "key_name" {
  type        = string
  default     = ""
  description = " Create your own keypair and specify key name"
}

variable "root_block_device_encrypted" {
  type        = bool
  default     = true
  description = "Whether to encrypt the root block device"
}

variable "root_block_device_volume_size" {
  type        = number
  default     = 8
  description = "The volume size (in GiB) to provision for the root block device. It cannot be smaller than the AMI it refers to."
}

variable "disable_api_termination" {
  type        = bool
  description = "Enable EC2 Instance Termination Protection"
  default     = false
}

variable "ebs_block_device_volume_size" {
  type        = number
  default     = 0
  description = "The volume size (in GiB) to provision for the EBS block device. Creation skipped if size is 0"
}

variable "monitoring" {
  type        = bool
  description = "Launched EC2 instance will have detailed monitoring enabled"
  default     = true
}

variable "metadata_http_endpoint_enabled" {
  type        = bool
  default     = true
  description = "Whether the metadata service is available"
}

variable "metadata_http_put_response_hop_limit" {
  type        = number
  default     = 1
  description = "The desired HTTP PUT response hop limit (between 1 and 64) for instance metadata requests."
}

variable "metadata_http_tokens_required" {
  type        = bool
  default     = true
  description = "Whether or not the metadata service requires session tokens, also referred to as Instance Metadata Service Version 2."
}

variable "associate_public_ip_address" {
  type        = bool
  default     = false
  description = "Whether to associate a public IP to the instance."
}

variable "assign_eip_address" {
  type        = bool
  description = "Assign an Elastic IP address to the instance"
  default     = true
}

variable "ami_filter" {
  description = "List of maps used to create the AMI filter for the action runner AMI."
  type        = map(list(string))

  default = {
    name = ["amzn2-ami-hvm-2.*-x86_64-ebs"]
  }
}

variable "ami_owners" {
  description = "The list of owners used to select the AMI of action runner instances."
  type        = list(string)
  default     = ["amazon"]
}

variable "ami" {
  type        = string
  description = "AMI to use for the instance. Setting this will ignore `ami_filter` and `ami_owners`."
  default     = null
}

variable "env" {
  type        = string
  description = "The name of environment: dev, stage, prod"
}
