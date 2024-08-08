<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.58.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.60.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ansible"></a> [ansible](#module\_ansible) | ./modules/ansible | n/a |
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ./modules/bastion | n/a |
| <a name="module_efs"></a> [efs](#module\_efs) | ./modules/efs | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | ./modules/eks | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |
| <a name="module_rds"></a> [rds](#module\_rds) | ./modules/rds | n/a |
| <a name="module_s3"></a> [s3](#module\_s3) | ./modules/s3 | n/a |
| <a name="module_secrets"></a> [secrets](#module\_secrets) | ./modules/secrets | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.website_cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_config"></a> [bastion\_config](#input\_bastion\_config) | bastion EC2 configuration | <pre>object({<br>    instance_type    = string<br>    volume_type      = string<br>    volume_size      = number<br>    source_cidr      = string<br>    public_key_path  = string<br>    private_key_path = string<br>  })</pre> | n/a | yes |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | Name of the module | <pre>object({<br>    prefix        = string<br>    force_destroy = bool<br>  })</pre> | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | AWS Tags to add to all resources created | `map(any)` | <pre>{<br>  "Application": "EKS",<br>  "Environment": "",<br>  "Name": "",<br>  "Owned by": "",<br>  "Terraform": "true",<br>  "Type": ""<br>}</pre> | no |
| <a name="input_eks"></a> [eks](#input\_eks) | EKS configuration | <pre>object({<br>    name                = string<br>    version             = string<br>    private_endpoint    = bool<br>    public_endpoint     = bool<br>    public_access_cidrs = list(string)<br>    control_plane_cidr  = string<br>  })</pre> | n/a | yes |
| <a name="input_eks_addons_version"></a> [eks\_addons\_version](#input\_eks\_addons\_version) | EKS addons | `map(string)` | n/a | yes |
| <a name="input_eks_node_group"></a> [eks\_node\_group](#input\_eks\_node\_group) | EKS node group configuration | <pre>object({<br>    name            = string<br>    disk_size       = number<br>    capacity_type   = string<br>    instance_types  = list(string)<br>    desired_size    = number<br>    max_size        = number<br>    min_size        = number<br>    max_unavailable = number<br>  })</pre> | n/a | yes |
| <a name="input_mariadb"></a> [mariadb](#input\_mariadb) | Database configuration values | <pre>object({<br>    engine                              = string<br>    engine_version                      = string<br>    instance_class                      = string<br>    allocated_storage                   = number<br>    max_allocated_storage               = number<br>    storage_encrypted                   = bool<br>    family                              = string<br>    db_name                             = string<br>    db_username                         = string<br>    manage_master_user_password         = bool<br>    port                                = string<br>    skip_final_snapshot                 = bool<br>    publicly_accessible                 = bool<br>    multi_az                            = bool<br>    iam_database_authentication_enabled = bool<br>  })</pre> | n/a | yes |
| <a name="input_net_cidr"></a> [net\_cidr](#input\_net\_cidr) | CIDR used in the project | <pre>object({<br>    vpc              = string,<br>    eks_subnet       = list(string),<br>    eks_subnet_mysql = list(string),<br>    rds_subnet       = list(string),<br>    pub_subnet       = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region where the project will initialize | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_public_ip"></a> [bastion\_public\_ip](#output\_bastion\_public\_ip) | n/a |
| <a name="output_cert_validation"></a> [cert\_validation](#output\_cert\_validation) | n/a |
<!-- END_TF_DOCS -->