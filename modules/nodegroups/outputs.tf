# Outputs IAM role ARN used by node groups
output "node_role_arn" {
  value = aws_iam_role.eks_node_group_role.arn
}

# Outputs private node group name
output "private_nodegroup_name" {
  value = aws_eks_node_group.private_node_group.node_group_name
}

# Outputs public node group name
output "public_nodegroup_name" {
  value = aws_eks_node_group.public_node_group.node_group_name
}
