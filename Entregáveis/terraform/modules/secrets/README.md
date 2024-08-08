<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_password.defect_dojo_admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.grafana_admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.rds_defect_dojo_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.rds_grafana_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.rds_wp_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.wp_admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_secretsmanager_secret.grafana_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret.rds_grafana](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret.rds_wp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret.storm_forge](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret.wp_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_password_config"></a> [password\_config](#input\_password\_config) | Password generation configuration | <pre>object({<br>    username_size = number<br>    password_size = number<br>    special       = bool<br>    special_chars = string<br>  })</pre> | <pre>{<br>  "password_size": 20,<br>  "special": true,<br>  "special_chars": "!@#$%^&*()_+-=[]{}|:,.<>?",<br>  "username_size": 5<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_grafana_admin_secret_arn"></a> [grafana\_admin\_secret\_arn](#output\_grafana\_admin\_secret\_arn) | n/a |
| <a name="output_rds_grafana_secret_arn"></a> [rds\_grafana\_secret\_arn](#output\_rds\_grafana\_secret\_arn) | n/a |
| <a name="output_rds_wp_secret_arn"></a> [rds\_wp\_secret\_arn](#output\_rds\_wp\_secret\_arn) | n/a |
| <a name="output_storm_forge_arn"></a> [storm\_forge\_arn](#output\_storm\_forge\_arn) | n/a |
| <a name="output_wp_admin_secret_arn"></a> [wp\_admin\_secret\_arn](#output\_wp\_admin\_secret\_arn) | n/a |
<!-- END_TF_DOCS -->