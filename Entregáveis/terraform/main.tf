terraform {
  backend "s3" {
    bucket = "henrique-s3-terraform-backend"
    key    = "wordpress-eks"
    region = "us-east-2"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.58.0"
    }
  }
}

provider "aws" {
  region                   = var.region
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "workload"

  default_tags {
    tags = var.default_tags
  }
}

data "aws_availability_zones" "available" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["*ubuntu-noble-24.04-amd64-server-20240701.1*"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}

resource "aws_acm_certificate" "website_cert" {
  domain_name       = "htsuyoshiy.online"
  validation_method = "DNS"

  subject_alternative_names = [
    "wordpress.htsuyoshiy.online",
    "grafana.htsuyoshiy.online",
    "kubernetes.htsuyoshiy.online",
    "kubecost.htsuyoshiy.online",
    "kube-ops-view.htsuyoshiy.online"
  ]

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Certificado - ${var.project_name}"
    Type = "ACM"
  }
}

module "network" {
  source                 = "./modules/network"
  project_name           = var.project_name
  availability_zones     = data.aws_availability_zones.available.names[*]
  net_cidr               = var.net_cidr
  bastion_source_cidr    = var.bastion_config.source_cidr
  eks_name               = var.eks.name
  eks_control_plane_cidr = var.eks.control_plane_cidr
  eks_worker_node_cidr   = var.net_cidr.eks_subnet
}

module "eks" {
  source                       = "./modules/eks"
  project_name                 = var.project_name
  vpc_id                       = module.network.vpc_id
  region                       = var.region
  private_eks_subnet_ids       = module.network.private_eks_subnet[*].id
  public_eks_subnet_ids        = module.network.public_subnet[*].id
  eks_worker_node_access_sg_id = module.network.eks_worker_node_access_sg_id
  eks_bastion_access_sg_id     = module.network.eks_bastion_access_sg_id
  eks                          = var.eks
  eks_addons_version           = var.eks_addons_version
  eks_node_group               = var.eks_node_group
  wp_admin_secret_arn          = module.secrets.wp_admin_secret_arn
  grafana_admin_secret_arn     = module.secrets.grafana_admin_secret_arn
  rds_wp_secret_arn            = module.secrets.rds_wp_secret_arn
  rds_grafana_secret_arn       = module.secrets.rds_grafana_secret_arn

  depends_on = [
    module.network
  ]
}

module "rds" {
  source                  = "./modules/rds"
  project_name            = var.project_name
  vpc_id                  = module.network.vpc_id
  private_rds_subnet_ids  = module.network.private_rds_subnet[*].id
  private_eks_subnet_cidr = var.net_cidr.eks_subnet
  rds_sg_id               = module.network.rds_sg_id
  availability_zone       = data.aws_availability_zones.available.names[0]
  mariadb                 = var.mariadb

  depends_on = [
    module.network
  ]
}

module "bastion" {
  source           = "./modules/bastion"
  project_name     = var.project_name
  region           = var.region
  image_ami_id     = data.aws_ami.ubuntu.id
  public_subnet_id = module.network.public_subnet[0].id
  bastion_sg_id    = module.network.bastion_sg_id
  bastion_config   = var.bastion_config
  eks_name         = var.eks.name
  eks_arn          = module.eks.eks_arn
  secrets_arn = [
    module.rds.rds_admin_secret_arn,
    module.secrets.rds_grafana_secret_arn,
    module.secrets.rds_wp_secret_arn,
    module.secrets.wp_admin_secret_arn,
    module.secrets.grafana_admin_secret_arn,
    module.secrets.storm_forge_arn,
  ]

  depends_on = [
    module.network,
    module.eks,
    module.rds,
    module.secrets,
  ]
}

module "efs" {
  source                  = "./modules/efs"
  project_name            = var.project_name
  vpc_id                  = module.network.vpc_id
  private_eks_subnet_ids  = module.network.private_eks_subnet[*].id
  efs_sg_id               = module.network.efs_sg_id

  depends_on = [
    module.network
  ]
}

module "s3" {
  source                 = "./modules/s3"
  project_name           = var.project_name
  bucket                 = var.bucket
  wp_federated_role_arn  = module.eks.wp_federated_role_arn
  wp_federated_role_name = module.eks.wp_federated_role_name

  depends_on = [
    module.eks
  ]
}

module "secrets" {
  source = "./modules/secrets"
}

module "ansible" {
  source                                   = "./modules/ansible"
  bastion_public_ip                        = module.bastion.public_ip
  bastion_config                           = var.bastion_config
  region                                   = var.region
  vpc_id                                   = module.network.vpc_id
  eks_node_group_name                      = var.eks_node_group.name
  eks_name                                 = var.eks.name
  eks_endpoint                             = module.eks.eks_endpoint
  private_eks_subnet_cidrs                 = var.net_cidr.eks_subnet_mysql[*]
  karpenter_instance_profile_name          = module.eks.karpenter_instance_profile_name
  rds_endpoint                             = module.rds.endpoint
  rds_admin_secret_arn                     = module.rds.rds_admin_secret_arn
  karpenter_federated_role_arn             = module.eks.karpenter_federated_role_arn
  grafana_federated_role_arn               = module.eks.grafana_federated_role_arn
  secret_csi_controller_federated_role_arn = module.eks.secret_csi_federated_role_arn
  alb_controller_federated_role_arn        = module.eks.alb_controller_federated_role_arn
  wp_federated_role_arn                    = module.eks.wp_federated_role_arn
  wp_offload_media_bucket_name             = module.s3.bucket_name
  wp_offload_media_cf                      = module.s3.cf_domain_name
  efs_id                                   = module.efs.wordpress_efs_id
  cert_arn                                 = aws_acm_certificate.website_cert.arn
  waf_wacl_arn                             = module.network.waf_wacl_arn

  depends_on = [
    module.network,
    module.eks,
    module.rds,
    module.s3,
    module.bastion
  ]
}