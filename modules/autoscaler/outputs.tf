# Outputs IAM role ARN used by cluster autoscaler
output "autoscaler_role_arn" {
  value = aws_iam_role.cluster_autoscaler_role.arn
}
