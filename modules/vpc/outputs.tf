# Outputs the VPC ID
output "vpc_id" {
  value = aws_vpc.vpc.id
}

# Outputs public subnet IDs
output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}

# Outputs private subnet IDs
output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}
