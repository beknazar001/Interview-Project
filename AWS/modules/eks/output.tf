output "endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "cacert" {
  value = base64decode(aws_eks_cluster.eks.certificate_authority[0].data)
}

output "token" {
  value = data.aws_eks_cluster_auth.token.token
}


data "aws_eks_cluster_auth" "token" {
  name = aws_eks_cluster.eks.name
}

