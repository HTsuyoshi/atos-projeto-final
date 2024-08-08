variable "vpc_id" {
  type        = string
  description = "ID of the VPC where the cluster will be launched"
  nullable    = false
}

variable "region" {
  type        = string
  description = "Region where the project will run"
  nullable    = false
}

variable "bastion_public_ip" {
  type        = string
  description = "Bastion public IP"
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
  description = "Bastion EC2 configuration"
  nullable    = false
}

variable "eks_node_group_name" {
  type        = string
  description = "EKS cluster name"
  nullable    = false
}

variable "eks_name" {
  type        = string
  description = "EKS cluster name"
  nullable    = false
}

variable "eks_endpoint" {
  type        = string
  description = "Cluster EKS endpoint"
  nullable    = false
}

variable "private_eks_subnet_cidrs" {
  type        = list(string)
  description = "Private EKS subnet CIDRs"
  nullable    = false
}

variable "rds_endpoint" {
  type        = string
  description = "Private RDS endpoint"
  nullable    = false
}

variable "rds_admin_secret_arn" {
  type        = string
  description = ""
  nullable    = false
}

variable "grafana_federated_role_arn" {
  type        = string
  description = "Role to upload files into the S3 bucket"
  nullable    = false
}

variable "karpenter_federated_role_arn" {
  type        = string
  description = "Role to provision new Nodes for the eks cluster"
  nullable    = false
}

variable "karpenter_instance_profile_name" {
  type        = string
  description = "Instance profile used by the karpenter provisioned instances"
  nullable    = false
}

variable "secret_csi_controller_federated_role_arn" {
  type        = string
  description = "Role to use AWS Secret manager as secrets inside kubernetes"
  nullable    = false
}

variable "alb_controller_federated_role_arn" {
  type        = string
  description = "Load balancer Role ARN for the Application Load Balancer Controller"
  nullable    = false
}

variable "wp_federated_role_arn" {
  type        = string
  description = "Role to upload files into the S3 bucket"
  nullable    = false
}

variable "wp_offload_media_bucket_name" {
  type        = string
  description = "Bucket name to hold static content by WP Offload media plugin"
  nullable    = false
}

variable "wp_offload_media_cf" {
  type        = string
  description = "Cloud front domain to cache bucket static content"
  nullable    = false
}

variable "efs_id" {
  type        = string
  description = "Elastic File System ID"
  nullable    = false
}

variable "cert_arn" {
  type        = string
  description = "ACM Certificate ARN"
  nullable    = false
}

variable "waf_wacl_arn" {
  type        = string
  description = "WAF Web ACL ARN"
  nullable    = false
}