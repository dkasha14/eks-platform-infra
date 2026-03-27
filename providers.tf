terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
}

# AWS provider for infrastructure
provider "aws" {
  region = var.region
}

# Fetch EKS cluster details
data "aws_eks_cluster" "eks_cluster_data" {
  name = module.eks.cluster_id
}

# Fetch authentication token for EKS
data "aws_eks_cluster_auth" "eks_cluster_auth_data" {
  name = module.eks.cluster_id
}

# Kubernetes provider to interact with cluster
provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks_cluster_data.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster_data.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks_cluster_auth_data.token
}

# Helm provider for deploying charts
provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks_cluster_data.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster_data.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks_cluster_auth_data.token
  }
}
