output "rds_wp_secret_arn" {
  value = data.aws_secretsmanager_secret.rds_wp.arn
}

output "rds_grafana_secret_arn" {
  value = data.aws_secretsmanager_secret.rds_grafana.arn
}

output "wp_admin_secret_arn" {
  value = data.aws_secretsmanager_secret.wp_admin.arn
}

output "grafana_admin_secret_arn" {
  value = data.aws_secretsmanager_secret.grafana_admin.arn
}

output "storm_forge_arn" {
  value = data.aws_secretsmanager_secret.storm_forge.arn
}