resource "aws_security_group" "bastion_sg" {
  name        = "bastion_sg"
  description = "security group"
  vpc_id      = aws_vpc.vpc_eks.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.bastion_source_cidr]
    description = "Allow developer connection to bastion instance"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outbound connection to all CIDRs"
  }

  tags = {
    Name = "Bastion Security Group - ${var.project_name}",
    Type = var.module_name
  }
}

resource "aws_security_group" "eks_worker_node_access_sg" {
  name        = "worker_node_access"
  description = "Let Worker Nodes access EKS control plane"
  vpc_id      = aws_vpc.vpc_eks.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
    description = "Allow nodes and pods access EKS cluster API"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outbound connection to all CIDRs"
  }

  tags = {
    Name = "EKS Cluster Worker Node Security Group - ${var.project_name}"
    Type = var.module_name
  }
}

resource "aws_security_group" "eks_bastion_access_sg" {
  name        = "bastion_access"
  description = "Let bastion access EKS control plane"
  vpc_id      = aws_vpc.vpc_eks.id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
    description     = "Allow bastion access EKS cluster API"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outbound connection to all CIDRs"
  }

  tags = {
    Name = "EKS Cluster Bastion Security Group - ${var.project_name}"
    Type = var.module_name
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "RDS security group"
  vpc_id      = aws_vpc.vpc_eks.id

  ingress {
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
    cidr_blocks = var.eks_worker_node_cidr
    description = "Allow EKS pods connect the RDS"
  }

  ingress {
    protocol        = "tcp"
    from_port       = 3306
    to_port         = 3306
    security_groups = [aws_security_group.bastion_sg.id]
    description     = "Allow bastion CIDR to configure the RDS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outbound connection to all CIDRs"
  }

  tags = {
    Name = "RDS Security group - ${var.project_name}",
    Type = var.module_name
  }
}

resource "aws_security_group" "efs_sg" {
  name        = "efs_sg"
  description = "Allow NFS traffic"
  vpc_id      = aws_vpc.vpc_eks.id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = var.eks_worker_node_cidr
    description = "Allow EKS wordpress pods connect to EFS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outbound connection to all CIDRs"
  }

  tags = {
    Name = "EFS - ${var.project_name}",
    Type = var.module_name
  }
}