output "vpc_id" {
  value = aws_vpc.vpc_eks.id
}

output "private_eks_subnet" {
  value = aws_subnet.private_eks_subnet
}

output "private_rds_subnet" {
  value = aws_subnet.private_rds_subnet
}

output "public_subnet" {
  value = aws_subnet.public_subnet
}

output "waf_wacl_arn" {
  value = aws_wafv2_web_acl.waf_wacl.arn
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}

output "efs_sg_id" {
  value = aws_security_group.efs_sg.id
}

output "eks_worker_node_access_sg_id" {
  value = aws_security_group.eks_worker_node_access_sg.id
}

output "eks_bastion_access_sg_id" {
  value = aws_security_group.eks_bastion_access_sg.id
}
