variable "project_name" {
  type        = string
  description = "Name of the project"
  nullable    = false
}

variable "module_name" {
  type        = string
  description = "Name of the module"
  nullable    = false

  default = "Networking"
}

variable "net_cidr" {
  type = object({
    vpc        = string,
    eks_subnet = list(string),
    rds_subnet = list(string)
    pub_subnet = list(string),
  })
  description = "CIDRs used in the project"
  nullable    = false
}

variable "availability_zones" {
  type = list(string)
  description = "List of AZs used in the project"
  nullable    = false
}

variable "bastion_source_cidr" {
  type = string
  description = "CIDRs allowed to connect to bastion"
  nullable    = false
}

variable "eks_name" {
  type        = string
  description = "EKS cluster name"
  nullable    = false
}

variable "eks_control_plane_cidr" {
  type        = string
  description = "EKS Control Plane CIDR"
  nullable    = false
}

variable "eks_worker_node_cidr" {
  type        = list(string)
  description = "List of EKS private Node subnets CIDR"
  nullable    = false
}