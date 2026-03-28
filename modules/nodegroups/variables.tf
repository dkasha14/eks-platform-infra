# EKS cluster name
variable "cluster_name" {
  type = string
}

variable "keypair" {
  type = string
}
# Public subnet IDs for node group
variable "public_subnet_ids" {
  type = list(string)
}

# Private subnet IDs for node group
variable "private_subnet_ids" {
  type = list(string)
}

# Common naming prefix
variable "name" {
  type = string
}

# Public node group capacity type (ON_DEMAND / SPOT)
variable "public_nodes_capacity" {
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

# Private node group capacity type (ON_DEMAND / SPOT)
variable "private_nodes_capacity" {
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

# Public node instance type
variable "public_nodes_type" {
  type = string
}

# Public node labels
variable "public_nodes_labels" {
  type = map(string)
}

# Private node instance type
variable "private_nodes_type" {
  type = string
}

# Private node labels
variable "private_nodes_labels" {
  type = map(string)
}

