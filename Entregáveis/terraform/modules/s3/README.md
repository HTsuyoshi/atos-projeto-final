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
| [aws_cloudfront_distribution.wp_static_content](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_control.cf_origin_access_control](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control) | resource |
| [aws_iam_policy.wp_offload_media_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.offload_media_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.wp_static_content](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.allow_access_from_cloud_front](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.unblock_public_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket"></a> [bucket](#input\_bucket) | Bucket configuration | <pre>object({<br>    prefix        = string<br>    force_destroy = bool<br>  })</pre> | <pre>{<br>  "force_destroy": true,<br>  "prefix": "wordpress_eks_static_content_"<br>}</pre> | no |
| <a name="input_module_name"></a> [module\_name](#input\_module\_name) | Name of the module | `string` | `"S3"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | n/a | yes |
| <a name="input_wp_federated_role_arn"></a> [wp\_federated\_role\_arn](#input\_wp\_federated\_role\_arn) | ARN of the role to upload files into the S3 bucket | `string` | n/a | yes |
| <a name="input_wp_federated_role_name"></a> [wp\_federated\_role\_name](#input\_wp\_federated\_role\_name) | Name of the role to upload files into the S3 bucket | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | n/a |
| <a name="output_cf_domain_name"></a> [cf\_domain\_name](#output\_cf\_domain\_name) | n/a |
<!-- END_TF_DOCS -->