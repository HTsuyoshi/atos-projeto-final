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
| [aws_efs_file_system.wordpress_efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.wordpress_efs_mount_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_efs_sg_id"></a> [efs\_sg\_id](#input\_efs\_sg\_id) | EFS Security Group ID to allow connection from EKS worker nodes | `string` | n/a | yes |
| <a name="input_module_name"></a> [module\_name](#input\_module\_name) | Name of the module | `string` | `"EFS"` | no |
| <a name="input_private_eks_subnet_ids"></a> [private\_eks\_subnet\_ids](#input\_private\_eks\_subnet\_ids) | List of subnet IDs | `list(string)` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_wordpress_efs_id"></a> [wordpress\_efs\_id](#output\_wordpress\_efs\_id) | n/a |
<!-- END_TF_DOCS -->