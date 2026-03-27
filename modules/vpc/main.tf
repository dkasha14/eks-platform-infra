# Local values used for consistent naming
locals {
  name = var.name
}

# Creates the main VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${local.name}-vpc"
  }
}

# Attaches Internet Gateway for public internet access
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.name}-igw"
  }
}

# Creates private subnets across availability zones
resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.private_subnets)
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name                                       = "${local.name}-priv-${substr(element(var.availability_zones, count.index), -2, 2)}"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

# Creates public subnets for internet-facing resources
resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.public_subnets) # fixed
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name                                       = "${local.name}-pub-${substr(element(var.availability_zones, count.index), -2, 2)}"
    "kubernetes.io/role/elb"                   = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

# Allocates Elastic IPs for NAT Gateways
resource "aws_eip" "nat_eip" {
  count = length(var.public_subnets) # fixed
  domain = "vpc"

  depends_on = [aws_internet_gateway.igw] # fixed

  tags = {
    Name = "${local.name}-nat-eip"
  }
}

# Creates NAT Gateways for private subnet internet access
resource "aws_nat_gateway" "nat_gw" {
  count         = length(var.public_subnets) # fixed
  allocation_id = element(aws_eip.nat_eip.*.id, count.index)
  subnet_id     = element(aws_subnet.public_subnets.*.id, count.index)

  tags = {
    Name = "${local.name}-nat-${substr(element(var.availability_zones, count.index), -2, 2)}"
  }
}

# Creates route table for public subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${local.name}-public-rt"
  }
}

# Creates route tables for private subnets using NAT
resource "aws_route_table" "private_rt" {
  count  = length(var.private_subnets) # fixed
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat_gw.*.id, count.index)
  }

  tags = {
    Name = "${local.name}-private-rt-${substr(element(var.availability_zones, count.index), -2, 2)}"
  }
}

# Associates public subnets with public route table
resource "aws_route_table_association" "public_rta" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

# Associates private subnets with corresponding private route tables
resource "aws_route_table_association" "private_rta" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt[count.index].id
}
