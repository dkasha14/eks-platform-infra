# Outputs EKS cluster ID
output "cluster_id" {
  value = aws_eks_cluster.eks_cluster_control_plane.id
}

# Outputs EKS API endpoint
output "cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster_control_plane.endpoint
}

# Outputs cluster CA certificate
output "cluster_ca_certificate" {
  value = aws_eks_cluster.eks_cluster_control_plane.certificate_authority[0].data
}

# Outputs OIDC provider ARN
output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.eks_oidc_provider.arn
}

# Outputs cluster security group ID (auto-created by EKS)
output "cluster_security_group_id" {
  value = aws_eks_cluster.eks_cluster_control_plane.vpc_config[0].cluster_security_group_id
}

# Outputs OIDC issuer URL
output "cluster_oidc_issuer_url" {
  value = aws_eks_cluster.eks_cluster_control_plane.identity[0].oidc[0].issuer
}
