resource "random_password" "rds_wp_password" {
  length           = var.password_config.password_size
  special          = false
  override_special = ""
}

resource "random_password" "rds_grafana_password" {
  length           = var.password_config.password_size
  special          = false
  override_special = ""
}

resource "random_password" "rds_defect_dojo_password" {
  length           = var.password_config.password_size
  special          = false
  override_special = ""
}

resource "random_password" "wp_admin_password" {
  length           = var.password_config.password_size
  special          = var.password_config.special
  override_special = var.password_config.special_chars
}

resource "random_password" "grafana_admin_password" {
  length           = var.password_config.password_size
  special          = var.password_config.special
  override_special = var.password_config.special_chars
}

resource "random_password" "defect_dojo_admin_password" {
  length           = var.password_config.password_size
  special          = false
  override_special = ""
}