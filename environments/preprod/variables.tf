# AWS region 
variable "region" {
  type = string
}

# Customer/project name
variable "customer" {
  type = string
}

# Environment (dev/sit/preprod/prod)
variable "env" {
  type = string
}

variable "keypair" {
  type = string
}

# EKS cluster name
variable "cluster_name" {
  type = string
}

# VPC CIDR block
variable "vpc_cidr" {
  type = string
}

# Public subnet CIDRs
variable "public_subnets" {
  type = list(string)
}

# Private subnet CIDRs
variable "private_subnets" {
  type = list(string)
}

# Availability zones
variable "availability_zones" {
  type = list(string)
}

# Public node group capacity type
variable "public_nodes_capacity" {
  type = string
}

# Public node instance type
variable "public_nodes_type" {
  type = string
}

# Public node group min size
variable "public_nodes_min" {
  type = number
}

# Public node group max size
variable "public_nodes_max" {
  type = number
}

# Public node group desired size
variable "public_nodes_des" {
  type = number
}

# Public node labels
variable "public_nodes_labels" {
  type = map(string)
}

# Private node group capacity type
variable "private_nodes_capacity" {
  type = string
}

# Private node instance type
variable "private_nodes_type" {
  type = string
}

# Private node group min size
variable "private_nodes_min" {
  type = number
}

# Private node group max size
variable "private_nodes_max" {
  type = number
}

# Private node group desired size
variable "private_nodes_des" {
  type = number
}

# Private node labels
variable "private_nodes_labels" {
  type = map(string)
}

# Kubernetes version
variable "kubernetes_version" {
  type = string
}
