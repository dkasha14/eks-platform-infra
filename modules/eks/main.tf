# Creates IAM role for EKS control plane
resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.name}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attaches required AWS managed policy to EKS role
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# Creates the EKS cluster control plane
resource "aws_eks_cluster" "eks_cluster_control_plane" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = concat(var.public_subnet_ids, var.private_subnet_ids)
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}

# Fetches TLS certificate for OIDC provider
data "tls_certificate" "eks_oidc_tls" {
  url = aws_eks_cluster.eks_cluster_control_plane.identity[0].oidc[0].issuer
}

# Creates IAM OIDC provider for IRSA
resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_oidc_tls.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.eks_cluster_control_plane.identity[0].oidc[0].issuer
}
