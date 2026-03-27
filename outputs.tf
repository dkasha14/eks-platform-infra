# EKS cluster details
output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

# VPC details
output "vpc_id" {
  value = module.vpc.vpc_id
}

# Nodegroup info
output "private_nodegroup_name" {
  value = module.nodegroups.private_nodegroup_name
}

output "public_nodegroup_name" {
  value = module.nodegroups.public_nodegroup_name
}
output "autoscaler_role_arn" {
  value = module.autoscaler.autoscaler_role_arn
}

