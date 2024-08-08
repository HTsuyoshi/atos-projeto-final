<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.setup_ansible](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_controller_federated_role_arn"></a> [alb\_controller\_federated\_role\_arn](#input\_alb\_controller\_federated\_role\_arn) | Load balancer Role ARN for the Application Load Balancer Controller | `string` | n/a | yes |
| <a name="input_bastion_config"></a> [bastion\_config](#input\_bastion\_config) | Bastion EC2 configuration | <pre>object({<br>    instance_type    = string<br>    volume_type      = string<br>    volume_size      = number<br>    source_cidr      = string<br>    public_key_path  = string<br>    private_key_path = string<br>  })</pre> | n/a | yes |
| <a name="input_bastion_public_ip"></a> [bastion\_public\_ip](#input\_bastion\_public\_ip) | Bastion public IP | `string` | n/a | yes |
| <a name="input_cert_arn"></a> [cert\_arn](#input\_cert\_arn) | ACM Certificate ARN | `string` | n/a | yes |
| <a name="input_efs_id"></a> [efs\_id](#input\_efs\_id) | Elastic File System ID | `string` | n/a | yes |
| <a name="input_eks_endpoint"></a> [eks\_endpoint](#input\_eks\_endpoint) | Cluster EKS endpoint | `string` | n/a | yes |
| <a name="input_eks_name"></a> [eks\_name](#input\_eks\_name) | EKS cluster name | `string` | n/a | yes |
| <a name="input_eks_node_group_name"></a> [eks\_node\_group\_name](#input\_eks\_node\_group\_name) | EKS cluster name | `string` | n/a | yes |
| <a name="input_grafana_federated_role_arn"></a> [grafana\_federated\_role\_arn](#input\_grafana\_federated\_role\_arn) | Role to upload files into the S3 bucket | `string` | n/a | yes |
| <a name="input_karpenter_federated_role_arn"></a> [karpenter\_federated\_role\_arn](#input\_karpenter\_federated\_role\_arn) | Role to provision new Nodes for the eks cluster | `string` | n/a | yes |
| <a name="input_karpenter_instance_profile_name"></a> [karpenter\_instance\_profile\_name](#input\_karpenter\_instance\_profile\_name) | Instance profile used by the karpenter provisioned instances | `string` | n/a | yes |
| <a name="input_private_eks_subnet_cidrs"></a> [private\_eks\_subnet\_cidrs](#input\_private\_eks\_subnet\_cidrs) | Private EKS subnet CIDRs | `list(string)` | n/a | yes |
| <a name="input_rds_admin_secret_arn"></a> [rds\_admin\_secret\_arn](#input\_rds\_admin\_secret\_arn) | n/a | `string` | n/a | yes |
| <a name="input_rds_endpoint"></a> [rds\_endpoint](#input\_rds\_endpoint) | Private RDS endpoint | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region where the project will run | `string` | n/a | yes |
| <a name="input_secret_csi_controller_federated_role_arn"></a> [secret\_csi\_controller\_federated\_role\_arn](#input\_secret\_csi\_controller\_federated\_role\_arn) | Role to use AWS Secret manager as secrets inside kubernetes | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where the cluster will be launched | `string` | n/a | yes |
| <a name="input_waf_wacl_arn"></a> [waf\_wacl\_arn](#input\_waf\_wacl\_arn) | WAF Web ACL ARN | `string` | n/a | yes |
| <a name="input_wp_federated_role_arn"></a> [wp\_federated\_role\_arn](#input\_wp\_federated\_role\_arn) | Role to upload files into the S3 bucket | `string` | n/a | yes |
| <a name="input_wp_offload_media_bucket_name"></a> [wp\_offload\_media\_bucket\_name](#input\_wp\_offload\_media\_bucket\_name) | Bucket name to hold static content by WP Offload media plugin | `string` | n/a | yes |
| <a name="input_wp_offload_media_cf"></a> [wp\_offload\_media\_cf](#input\_wp\_offload\_media\_cf) | Cloud front domain to cache bucket static content | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->