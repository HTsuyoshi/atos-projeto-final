#resource "aws_secretsmanager_secret" "rds_wp" {
#  name        = "rds-wp-credentials"
#  description = "RDS wp credentials"
#}
#
#resource "aws_secretsmanager_secret_version" "rds_wp_version" {
#  secret_id = aws_secretsmanager_secret.rds_wp.id
#  secret_string = jsonencode({
#    username = "wp_user"
#    password = random_password.rds_wp_password.result
#  })
#}
#
#resource "aws_secretsmanager_secret" "rds_grafana" {
#  name        = "rds-grafana-credentials"
#  description = "RDS Grafana credentials"
#}
#
#resource "aws_secretsmanager_secret_version" "rds_grafana_version" {
#  secret_id = aws_secretsmanager_secret.rds_grafana.id
#  secret_string = jsonencode({
#    username = "grafana_user"
#    password = random_password.rds_grafana_password.result
#  })
#}
#
#resource "aws_secretsmanager_secret" "wp_admin" {
#  name        = "wp-credentials"
#  description = "wp credentials"
#}
#
#resource "aws_secretsmanager_secret_version" "wp_admin_secret_version" {
#  secret_id = aws_secretsmanager_secret.wp_admin.id
#  secret_string = jsonencode({
#    username = "eks_wp_admin"
#    password = random_password.wp_admin_password.result
#  })
#}
#
#resource "aws_secretsmanager_secret" "grafana_admin" {
#  name        = "grafana-credentials"
#  description = "grafana-credentials"
#}
#
#resource "aws_secretsmanager_secret_version" "grafana_admin_secret_version" {
#  secret_id = aws_secretsmanager_secret.grafana_admin.id
#  secret_string = jsonencode({
#    username = "grafana_admin"
#    password = random_password.grafana_admin_password.result
#  })
#}

data "aws_secretsmanager_secret" "rds_wp" {
  name = "rds-wp-credentials"
}

data "aws_secretsmanager_secret" "rds_grafana" {
  name = "rds-grafana-credentials"
}

data "aws_secretsmanager_secret" "wp_admin" {
  name = "wp-credentials"
}

data "aws_secretsmanager_secret" "grafana_admin" {
  name = "grafana-credentials"
}

data "aws_secretsmanager_secret" "storm_forge" {
  name = "stormforge-credentials"
}