variable "project_name" {
  type        = string
  description = "Name of the project"
  nullable    = false
}

variable "module_name" {
  type        = string
  description = "Name of the module"
  nullable    = false

  default = "Relational Database Service"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where the cluster will be launched"
  nullable    = false
}

variable "private_rds_subnet_ids" {
  type        = list(string)
  description = "List of the database subnet group"
  nullable    = false
}

variable "private_eks_subnet_cidr" {
  type        = list(string)
  description = "List of EKS worker nodes subnet CIDRs"
  nullable    = false
}

variable "rds_sg_id" {
  type        = string
  description = "RDS Security Group ID to allow access to Bastion and EKS Nodes"
  nullable    = false
}

variable "availability_zone" {
  type = string
  description = "Database AZ"
  nullable    = false
}

variable "mariadb" {
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
  description = "Database configuration values"
  nullable    = false
}