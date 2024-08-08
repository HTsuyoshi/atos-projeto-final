<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.wp_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.private_rds_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | Database AZ | `string` | n/a | yes |
| <a name="input_mariadb"></a> [mariadb](#input\_mariadb) | Database configuration values | <pre>object({<br>    engine                              = string<br>    engine_version                      = string<br>    instance_class                      = string<br>    allocated_storage                   = number<br>    max_allocated_storage               = number<br>    storage_encrypted                   = bool<br>    family                              = string<br>    db_name                             = string<br>    db_username                         = string<br>    manage_master_user_password         = bool<br>    port                                = string<br>    skip_final_snapshot                 = bool<br>    publicly_accessible                 = bool<br>    multi_az                            = bool<br>    iam_database_authentication_enabled = bool<br>  })</pre> | n/a | yes |
| <a name="input_module_name"></a> [module\_name](#input\_module\_name) | Name of the module | `string` | `"Relational Database Service"` | no |
| <a name="input_private_eks_subnet_cidr"></a> [private\_eks\_subnet\_cidr](#input\_private\_eks\_subnet\_cidr) | List of EKS worker nodes subnet CIDRs | `list(string)` | n/a | yes |
| <a name="input_private_rds_subnet_ids"></a> [private\_rds\_subnet\_ids](#input\_private\_rds\_subnet\_ids) | List of the database subnet group | `list(string)` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | n/a | yes |
| <a name="input_rds_sg_id"></a> [rds\_sg\_id](#input\_rds\_sg\_id) | RDS Security Group ID to allow access to Bastion and EKS Nodes | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where the cluster will be launched | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
| <a name="output_rds_admin_secret_arn"></a> [rds\_admin\_secret\_arn](#output\_rds\_admin\_secret\_arn) | n/a |
<!-- END_TF_DOCS -->