output "endpoint" {
  value = split(":", aws_db_instance.wp_db.endpoint)[0]
}

output "rds_admin_secret_arn" {
  value = aws_db_instance.wp_db.master_user_secret[0].secret_arn
}