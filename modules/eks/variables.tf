# EKS cluster name
variable "cluster_name" {
  type = string
}

# AWS region
variable "region" {
  type = string
}

# VPC ID where EKS will be deployed
variable "vpc_id" {
  type = string
}

# Private subnet IDs for worker nodes
variable "private_subnet_ids" {
  type = list(string)
}

# Public subnet IDs for load balancers
variable "public_subnet_ids" {
  type = list(string)
}

# Environment name (dev/sit/prod)
variable "env" {
  type = string
}

# Customer/project identifier
variable "customer" {
  type = string
}

# Common naming prefix
variable "name" {
  type = string
}

# Kubernetes version for EKS
variable "kubernetes_version" {
  type = string
}
