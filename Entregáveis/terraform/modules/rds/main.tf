resource "aws_db_subnet_group" "private_rds_subnet_group" {
  name       = "private_rds_subnet_group"
  subnet_ids = var.private_rds_subnet_ids

  tags = {
    Name = "Subnet group private RDS - ${var.project_name}",
    Type = var.module_name
  }
}

resource "aws_db_instance" "wp_db" {
  identifier = "wordpress-eks-cluster-rds"

  engine                = var.mariadb.engine
  engine_version        = var.mariadb.engine_version
  instance_class        = var.mariadb.instance_class
  allocated_storage     = var.mariadb.allocated_storage
  max_allocated_storage = var.mariadb.max_allocated_storage
  storage_encrypted     = var.mariadb.storage_encrypted

  db_name                     = var.mariadb.db_name
  username                    = var.mariadb.db_username
  manage_master_user_password = var.mariadb.manage_master_user_password
  port                        = var.mariadb.port

  iam_database_authentication_enabled = var.mariadb.iam_database_authentication_enabled

  skip_final_snapshot = var.mariadb.skip_final_snapshot
  publicly_accessible = var.mariadb.publicly_accessible

  multi_az               = var.mariadb.multi_az
  availability_zone      = var.availability_zone
  db_subnet_group_name   = aws_db_subnet_group.private_rds_subnet_group.name
  vpc_security_group_ids = [var.rds_sg_id]

  tags = {
    Name = "RDS Wordpress - ${var.project_name}"
    Type = var.module_name
  }
}
