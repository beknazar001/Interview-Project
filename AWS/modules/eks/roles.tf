resource "aws_iam_role" "eks_cluster" {
  # The name of the role
  name = var.eks_name

  # The policy that grants an entity permission to assume the role.
  # Used to access AWS resources that you might not normally have access to.
  # The role that Amazon EKS will use to create AWS resources for Kubernetes clusters
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


resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
  # This policy will give permissions to eks itself
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

  # The role the policy should be applied to
  role = aws_iam_role.eks_cluster.name
}


##############################################################################################################

# Create IAM role for EKS Node Group
resource "aws_iam_role" "nodes_general" {
  # The name of the role
  name = "eks-node-group-general"

  # The policy that grants an entity permission to assume the role.
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


resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy_general" {
  # This policy will allow us to describe instances, volumes and etc.
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

  # The role the policy should be applied to
  role = aws_iam_role.nodes_general.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_general" {
  # This policy will allow us to manage network components.
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

  # The role the policy should be applied to
  role = aws_iam_role.nodes_general.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  # This policy will allow us to download the private images from ECR repository.
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

  # The role the policy should be applied to
  role = aws_iam_role.nodes_general.name
}
resource "aws_iam_policy" "ecr-policy" {
  name        = "ecr-policy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:BatchCheckLayerAvailability",
                "ecr:BatchGetImage",
                "ecr:GetDownloadUrlForLayer",
                "ecr:GetAuthorizationToken"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "aws_iam_role_policy_attachment" {
  # This policy will allow us to download the private images from ECR repository.
  policy_arn = aws_iam_policy.ecr-policy.arn

  # The role the policy should be applied to
  role = aws_iam_role.nodes_general.name
}