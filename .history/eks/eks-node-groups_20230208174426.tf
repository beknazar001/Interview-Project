resource "aws_eks_node_group" "nodes_general" {
  # Name of the EKS Cluster.
  cluster_name = var.cluster_name

  # Name of the EKS Node Group.
  node_group_name = var.node_group_name

  # Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group.
  node_role_arn = aws_iam_role.nodes_general.arn

  # Identifiers of EC2 Subnets to associate with the EKS Node Group. 
  # These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME 
  # (where CLUSTER_NAME is replaced with the name of the EKS Cluster).
  subnet_ids = var.node_subnets
  /* launch_template {
    name = aws_launch_template.cluster.name
    version = aws_launch_template.cluster.latest_version
  } */

  # Configuration block with scaling settings
  scaling_config {
    # Desired number of worker nodes.
    desired_size = var.desired_size

    # Maximum number of worker nodes.
    max_size = var.max_size

    # Minimum number of worker nodes.
    min_size = var.min_size
  }

  # Type of Amazon Machine Image (AMI) associated with the EKS Node Group.
  # Valid values: AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64
  ami_type = var.ami_type

  # Type of capacity associated with the EKS Node Group. 
  # Valid values: ON_DEMAND, SPOT
  capacity_type = var.capacity_type

  # Disk size in GiB for worker nodes
  disk_size = var.disk_size

  # Force version update if existing pods are unable to be drained due to a pod disruption budget issue.
  force_update_version = var.force_update_version

  # List of instance types associated with the EKS Node Group
  instance_types = var.instance_types

  labels = {
    role = "nodes-general"
  }

  # Kubernetes version
  version = var.eks_version

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
    aws_eks_cluster.eks
  ]
}

/* resource "aws_launch_template" "cluster" {
  instance_type          = "t3.medium"
  name                   = "eks-launch-template-test"
  update_default_version = true
  image_id = "AL2_x86_64"

  key_name = "eks-test"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name                        = "eks-node-group-instance-name"
      "kubernetes.io/cluster/eks" = "owned"
    }
  }
} */