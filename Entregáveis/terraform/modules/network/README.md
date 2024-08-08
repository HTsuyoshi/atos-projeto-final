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
| [aws_eip.nat_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.eks_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.nat_igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private_eks_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.private_rds_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_nat_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_assoc_rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private_eks_rt_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_assoc_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.bastion_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.efs_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.eks_bastion_access_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.eks_worker_node_access_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.rds_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.private_eks_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private_rds_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc_eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_wafv2_web_acl.waf_wacl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of AZs used in the project | `list(string)` | n/a | yes |
| <a name="input_bastion_source_cidr"></a> [bastion\_source\_cidr](#input\_bastion\_source\_cidr) | CIDRs allowed to connect to bastion | `string` | n/a | yes |
| <a name="input_eks_control_plane_cidr"></a> [eks\_control\_plane\_cidr](#input\_eks\_control\_plane\_cidr) | EKS Control Plane CIDR | `string` | n/a | yes |
| <a name="input_eks_name"></a> [eks\_name](#input\_eks\_name) | EKS cluster name | `string` | n/a | yes |
| <a name="input_eks_worker_node_cidr"></a> [eks\_worker\_node\_cidr](#input\_eks\_worker\_node\_cidr) | List of EKS private Node subnets CIDR | `list(string)` | n/a | yes |
| <a name="input_module_name"></a> [module\_name](#input\_module\_name) | Name of the module | `string` | `"Networking"` | no |
| <a name="input_net_cidr"></a> [net\_cidr](#input\_net\_cidr) | CIDRs used in the project | <pre>object({<br>    vpc        = string,<br>    eks_subnet = list(string),<br>    rds_subnet = list(string)<br>    pub_subnet = list(string),<br>  })</pre> | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_sg_id"></a> [bastion\_sg\_id](#output\_bastion\_sg\_id) | n/a |
| <a name="output_efs_sg_id"></a> [efs\_sg\_id](#output\_efs\_sg\_id) | n/a |
| <a name="output_eks_bastion_access_sg_id"></a> [eks\_bastion\_access\_sg\_id](#output\_eks\_bastion\_access\_sg\_id) | n/a |
| <a name="output_eks_worker_node_access_sg_id"></a> [eks\_worker\_node\_access\_sg\_id](#output\_eks\_worker\_node\_access\_sg\_id) | n/a |
| <a name="output_private_eks_subnet"></a> [private\_eks\_subnet](#output\_private\_eks\_subnet) | n/a |
| <a name="output_private_rds_subnet"></a> [private\_rds\_subnet](#output\_private\_rds\_subnet) | n/a |
| <a name="output_public_subnet"></a> [public\_subnet](#output\_public\_subnet) | n/a |
| <a name="output_rds_sg_id"></a> [rds\_sg\_id](#output\_rds\_sg\_id) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
| <a name="output_waf_wacl_arn"></a> [waf\_wacl\_arn](#output\_waf\_wacl\_arn) | n/a |
<!-- END_TF_DOCS -->