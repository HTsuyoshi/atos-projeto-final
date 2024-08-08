variable "project_name" {
  type        = string
  description = "Name of the project"
  nullable    = false
}

variable "module_name" {
  type        = string
  description = "Name of the module"
  nullable    = false

  default = "S3"
}

variable "bucket" {
  type = object({
    prefix        = string
    force_destroy = bool
  })
  description = "Bucket configuration"
  nullable    = false

  default = {
    prefix        = "wordpress_eks_static_content_"
    force_destroy = true
  }
}

variable "wp_federated_role_name" {
  type        = string
  description = "Name of the role to upload files into the S3 bucket"
  nullable    = false
}

variable "wp_federated_role_arn" {
  type        = string
  description = "ARN of the role to upload files into the S3 bucket"
  nullable    = false
}