variable "records" {
  type = list(object({
    domain_name           = string,
    resource_record_name  = string,
    resource_record_type  = string,
    resource_record_value = string
  }))
  description = "EKS node group configuration"
  nullable    = false
}

variable "ingress" {
  type        = string
  description = "Ingress hostname"
  nullable    = false
}
