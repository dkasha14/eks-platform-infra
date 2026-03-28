region       = "us-east-1"

customer     = "asha"
env          = "sit"
cluster_name = "EKS-SIT"

keypair = "asha.nvirg"

vpc_cidr = "10.20.0.0/16"

public_subnets  = ["10.20.10.0/24", "10.20.15.0/24"]
private_subnets = ["10.20.20.0/24", "10.20.25.0/24"]
public_nodes_type   = "t2.medium"
public_nodes_labels = { env = "public" }

private_nodes_type   = "t2.small"
private_nodes_labels = { env = "private" }
availability_zones = ["us-east-1a", "us-east-1b"]

# Node groups – same as dev
public_nodes_capacity = "ON_DEMAND"
public_nodes_min      = 1
public_nodes_max      = 2
public_nodes_des      = 1

private_nodes_capacity = "ON_DEMAND"
private_nodes_min      = 0
private_nodes_max      = 1 
private_nodes_des      = 1

kubernetes_version = "1.29"
