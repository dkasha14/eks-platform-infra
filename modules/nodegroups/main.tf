# Creates IAM role for EKS worker nodes
resource "aws_iam_role" "eks_node_group_role" {
  name = "${var.name}-eks-node-group-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Attaches worker node policy
resource "aws_iam_role_policy_attachment" "worker_node_policy" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Attaches CNI policy for networking
resource "aws_iam_role_policy_attachment" "cni_policy" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

# Attaches ECR read-only policy
resource "aws_iam_role_policy_attachment" "ecr_policy" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Launch template for PUBLIC nodes
resource "aws_launch_template" "public_nodes_launch_template" {
  name_prefix = "${var.name}-public-node-"
  key_name    = var.keypair

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name     = "${var.name}-public-node"
      NodeType = "public"
    }
  }
}

# Launch template for PRIVATE nodes
resource "aws_launch_template" "private_nodes_launch_template" {
  name_prefix = "${var.name}-private-node-"
  key_name    = var.keypair

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name     = "${var.name}-private-node"
      NodeType = "private"
    }
  }
}

# Creates private node group
resource "aws_eks_node_group" "private_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.name}-private-nodes"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn

  subnet_ids = var.private_subnet_ids
  instance_types = [var.private_nodes_type]

  labels = var.private_nodes_labels

  launch_template {
    id      = aws_launch_template.private_nodes_launch_template.id
    version = "$Latest"
  }

  scaling_config {
    desired_size = var.private_nodes_des
    max_size     = var.private_nodes_max
    min_size     = var.private_nodes_min
  }

  capacity_type = var.private_nodes_capacity

  depends_on = [
    aws_iam_role_policy_attachment.worker_node_policy,
    aws_iam_role_policy_attachment.cni_policy,
    aws_iam_role_policy_attachment.ecr_policy
  ]

  tags = {
    NodeType = "private"
  }
}

# Creates public node group
resource "aws_eks_node_group" "public_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.name}-public-nodes"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn

  subnet_ids = var.public_subnet_ids
  instance_types = [var.public_nodes_type]

  labels = var.public_nodes_labels

  launch_template {
    id      = aws_launch_template.public_nodes_launch_template.id
    version = "$Latest"
  }

  scaling_config {
    desired_size = var.public_nodes_des
    max_size     = var.public_nodes_max
    min_size     = var.public_nodes_min
  }

  capacity_type = var.public_nodes_capacity

  depends_on = [
    aws_iam_role_policy_attachment.worker_node_policy,
    aws_iam_role_policy_attachment.cni_policy,
    aws_iam_role_policy_attachment.ecr_policy
  ]

  tags = {
    NodeType = "public"
  }
}
