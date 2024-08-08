#resource "aws_network_acl" "private_eks_nacl" {
#  vpc_id     = aws_vpc.vpc_eks.id
#  subnet_ids = aws_subnet.private_eks_subnet[*].id
#
#  #ingress {
#  #  rule_no    = 100
#  #  from_port  = 0
#  #  to_port    = 0
#  #  protocol   = "-1"
#  #  cidr_block = var.eks_control_plane_cidr
#  #  action     = "allow"
#  #}
#
#  dynamic "ingress" {
#    for_each = aws_subnet.private_eks_subnet[*].cidr_block
#    content {
#      rule_no    = 100 + ingress.key
#      from_port  = 0
#      to_port    = 0
#      protocol   = "-1"
#      cidr_block = ingress.value
#      action     = "allow"
#    }
#  }
#
#  ingress {
#    rule_no    = 110
#    from_port  = 6443
#    to_port    = 6443
#    protocol   = "tcp"
#    cidr_block = var.eks_control_plane_cidr
#    action     = "allow"
#  }
#
#  ingress {
#    rule_no    = 120
#    from_port  = 80
#    to_port    = 80
#    protocol   = "6"
#    cidr_block = "0.0.0.0/0"
#    action     = "allow"
#  }
#  
#  ingress {
#    rule_no    = 130
#    from_port  = 443
#    to_port    = 443
#    protocol   = "6"
#    cidr_block = "0.0.0.0/0"
#    action     = "allow"
#  }
#
#  #ingress {
#  #  rule_no    = 10
#  #  from_port  = 1024
#  #  to_port    = 65535
#  #  protocol   = "tcp"
#  #  cidr_block = "0.0.0.0/0"
#  #  action     = "allow"
#  #}
#
#  ingress {
#    rule_no    = 140
#    from_port  = 53
#    to_port    = 53
#    protocol   = "tcp"
#    cidr_block = "0.0.0.0/0"
#    action     = "allow"
#  }
#
#  ingress {
#    rule_no    = 141
#    from_port  = 53
#    to_port    = 53
#    protocol   = "udp"
#    cidr_block = "0.0.0.0/0"
#    action     = "allow"
#  }
#
#  ingress {
#    rule_no    = 150
#    from_port  = 0
#    to_port    = 0
#    protocol   = "-1"
#    cidr_block = "0.0.0.0/0"
#    action     = "deny"
#  }
#
#  egress {
#    rule_no    = 100
#    from_port  = 80
#    to_port    = 80
#    protocol   = "6"
#    cidr_block = "0.0.0.0/0"
#    action     = "allow"
#  }
#  
#  egress {
#    rule_no    = 110
#    from_port  = 443
#    to_port    = 443
#    protocol   = "6"
#    cidr_block = "0.0.0.0/0"
#    action     = "allow"
#  }
#
#  egress {
#    rule_no    = 120
#    from_port  = 0
#    to_port    = 0
#    protocol   = "-1"
#    cidr_block = "0.0.0.0/0"
#    action     = "deny"
#  }
#
#  tags = {
#    Name = "Network ACL EKS - ${var.project_name}",
#    Type = var.module_name
#  }
#}
#
#resource "aws_network_acl" "public_subnet_nacl" {
#  vpc_id     = aws_vpc.vpc_eks.id
#  subnet_ids = aws_subnet.public_subnet[*].id
#
#  ingress {
#    rule_no    = 100
#    from_port  = 0
#    to_port    = 0
#    protocol   = "-1"
#    cidr_block = "0.0.0.0/0"
#    action     = "allow"
#  }
#
#  egress {
#    rule_no    = 100
#    from_port  = 0
#    to_port    = 0
#    protocol   = "-1"
#    cidr_block = "0.0.0.0/0"
#    action     = "allow"
#  }
#
#  tags = {
#    Name = "Network ACL Public Subnet - ${var.project_name}",
#    Type = var.module_name
#  }
#}
#
#resource "aws_network_acl" "private_rds_nacl" {
#  vpc_id     = aws_vpc.vpc_eks.id
#  subnet_ids = aws_subnet.private_rds_subnet[*].id
#
#  dynamic "ingress" {
#    for_each = var.net_cidr.eks_subnet
#    content {
#      rule_no    = 100 + ingress.key
#      from_port  = 3306
#      to_port    = 3306
#      protocol   = "tcp"
#      cidr_block = ingress.value
#      action     = "allow"
#    }
#  }
#
#  dynamic "ingress" {
#    for_each = var.net_cidr.eks_subnet
#    content {
#      rule_no    = 110 + ingress.key
#      from_port  = 1024
#      to_port    = 65535
#      protocol   = "tcp"
#      cidr_block = ingress.value
#      action     = "allow"
#    }
#  }
#
#  ingress {
#    rule_no    = 120
#    from_port  = 3306
#    to_port    = 3306
#    protocol   = "tcp"
#    cidr_block = "${var.bastion_private_ip}/32"
#    action     = "allow"
#  }
#
#  ingress {
#      rule_no    = 130
#      from_port  = 1024
#      to_port    = 65535
#      protocol   = "tcp"
#      cidr_block = "${var.bastion_private_ip}/32"
#      action     = "allow"
#  }
#
#  dynamic "egress" {
#    for_each = var.net_cidr.eks_subnet
#    content {
#      rule_no    = 100 + ingress.key
#      from_port  = 3306
#      to_port    = 3306
#      protocol   = "tcp"
#      cidr_block = ingress.value
#      action     = "allow"
#    }
#  }
#
#  dynamic "egress" {
#    for_each = var.net_cidr.eks_subnet
#    content {
#      rule_no    = 110 + ingress.key
#      from_port  = 1024
#      to_port    = 65535
#      protocol   = "tcp"
#      cidr_block = ingress.value
#      action     = "allow"
#    }
#  }
#
#  egress {
#    rule_no    = 120
#    from_port  = 3306
#    to_port    = 3306
#    protocol   = "tcp"
#    cidr_block = "${var.bastion_private_ip}/32"
#    action     = "allow"
#  }
#
#  egress {
#      rule_no    = 130
#      from_port  = 1024
#      to_port    = 65535
#      protocol   = "tcp"
#      cidr_block = "${var.bastion_private_ip}/32"
#      action     = "allow"
#  }
#
#  tags = {
#    Name = "Network ACL RDS - ${var.project_name}",
#    Type = var.module_name
#  }
#}