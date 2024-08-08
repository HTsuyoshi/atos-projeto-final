resource "aws_vpc" "vpc_eks" {
  cidr_block           = var.net_cidr.vpc
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "VPC - ${var.project_name}",
    Type = var.module_name
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.net_cidr.pub_subnet)
  vpc_id                  = aws_vpc.vpc_eks.id
  cidr_block              = var.net_cidr.pub_subnet[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  depends_on              = [aws_vpc.vpc_eks]

  tags = {
    Name                     = "Subnet ${var.availability_zones[count.index]} NAT - ${var.project_name}"
    Type                     = var.module_name
    "kubernetes.io/role/elb" = 1
  }
}

resource "aws_subnet" "private_eks_subnet" {
  count                   = length(var.net_cidr.eks_subnet)
  vpc_id                  = aws_vpc.vpc_eks.id
  cidr_block              = var.net_cidr.eks_subnet[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = false
  depends_on              = [aws_vpc.vpc_eks]

  tags = {
    Name                                    = "Subnet ${var.availability_zones[count.index]} EKS - ${var.project_name}"
    Type                                    = var.module_name
    "kubernetes.io/role/internal-elb"       = 1
    "kubernetes.io/cluster/${var.eks_name}" = "shared"
    "karpenter.sh/discovery"                = "${var.eks_name}"
  }
}

resource "aws_subnet" "private_rds_subnet" {
  count                   = length(var.net_cidr.rds_subnet)
  vpc_id                  = aws_vpc.vpc_eks.id
  cidr_block              = var.net_cidr.rds_subnet[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = false
  depends_on              = [aws_vpc.vpc_eks]

  tags = {
    Name = "Subnet ${var.availability_zones[count.index]} RDS - ${var.project_name}"
    Type = var.module_name
  }
}
