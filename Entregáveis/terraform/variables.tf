variable "region" {
  type        = string
  description = "Region where the project will initialize"
  nullable    = false
}

variable "project_name" {
  type        = string
  description = "Name of the project"
  nullable    = false
}

variable "net_cidr" {
  type = object({
    vpc              = string,
    eks_subnet       = list(string),
    eks_subnet_mysql = list(string),
    rds_subnet       = list(string),
    pub_subnet       = list(string)
  })
  description = "CIDR used in the project"
  nullable    = false
}

variable "eks" {
  type = object({
    name                = string
    version             = string
    private_endpoint    = bool
    public_endpoint     = bool
    public_access_cidrs = list(string)
    control_plane_cidr  = string
  })
  description = "EKS configuration"
  nullable    = false
}

variable "eks_addons_version" {
  type        = map(string)
  description = "EKS addons"
  nullable    = false
}

variable "eks_node_group" {
  type = object({
    name            = string
    disk_size       = number
    capacity_type   = string
    instance_types  = list(string)
    desired_size    = number
    max_size        = number
    min_size        = number
    max_unavailable = number
  })
  description = "EKS node group configuration"
  nullable    = false
}

variable "bastion_config" {
  type = object({
    instance_type    = string
    volume_type      = string
    volume_size      = number
    source_cidr      = string
    public_key_path  = string
    private_key_path = string
  })
  description = "bastion EC2 configuration"
  nullable    = false
}

variable "mariadb" {
  description = "Database configuration values"
  type = object({
    engine                              = string
    engine_version                      = string
    instance_class                      = string
    allocated_storage                   = number
    max_allocated_storage               = number
    storage_encrypted                   = bool
    family                              = string
    db_name                             = string
    db_username                         = string
    manage_master_user_password         = bool
    port                                = string
    skip_final_snapshot                 = bool
    publicly_accessible                 = bool
    multi_az                            = bool
    iam_database_authentication_enabled = bool
  })
}

variable "bucket" {
  type = object({
    prefix        = string
    force_destroy = bool
  })
  description = "Name of the module"
  nullable    = false
}

variable "default_tags" {
  type        = map(any)
  description = "AWS Tags to add to all resources created"
  nullable    = false

  default = {
    Application = "EKS",
    Terraform   = "true",
    Environment = "",
    "Owned by"  = "",
    Name        = "",
    Type        = "",
  }
}
