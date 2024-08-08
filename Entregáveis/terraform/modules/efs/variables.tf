variable "project_name" {
  type        = string
  description = "Name of the project"
  nullable    = false
}

variable "module_name" {
  type        = string
  description = "Name of the module"
  nullable    = false

  default = "EFS"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
  nullable    = false
}

variable "private_eks_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs"
  nullable    = false
}

variable "efs_sg_id" {
  type        = string
  description = "EFS Security Group ID to allow connection from EKS worker nodes"
  nullable    = false
}