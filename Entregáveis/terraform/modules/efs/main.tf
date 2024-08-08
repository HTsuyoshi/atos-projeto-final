resource "aws_efs_file_system" "wordpress_efs" {
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  tags = {
    Name = "EFS - ${var.project_name}",
    Type = var.module_name
  }
}

resource "aws_efs_mount_target" "wordpress_efs_mount_target" {
  count           = length(var.private_eks_subnet_ids)
  file_system_id  = aws_efs_file_system.wordpress_efs.id
  subnet_id       = var.private_eks_subnet_ids[count.index]
  security_groups = [var.efs_sg_id]
}