terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.54.0"
    }
  }
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "route53"

  default_tags {
    tags = {
      "Project"   = "Atos",
      "Terraform" = true
    }
  }
}

data "aws_route53_zone" "website" {
  name         = "htsuyoshiy.online."
  private_zone = false
}

resource "aws_route53_record" "validate_record" {
  count   = length(var.records)
  zone_id = data.aws_route53_zone.website.zone_id
  name    = var.records[count.index].resource_record_name
  type    = var.records[count.index].resource_record_type
  ttl     = 300
  records = [var.records[count.index].resource_record_value]
}

resource "aws_route53_record" "wordpress_ingress_record" {
  zone_id = data.aws_route53_zone.website.zone_id
  name    = "wordpress.htsuyoshiy.online"
  type    = "CNAME"
  ttl     = 300
  records = [var.ingress]
}

resource "aws_route53_record" "grafana_ingress_record" {
  zone_id = data.aws_route53_zone.website.zone_id
  name    = "grafana.htsuyoshiy.online"
  type    = "CNAME"
  ttl     = 300
  records = [var.ingress]
}

resource "aws_route53_record" "kubernetes_ingress_record" {
  zone_id = data.aws_route53_zone.website.zone_id
  name    = "kubernetes.htsuyoshiy.online"
  type    = "CNAME"
  ttl     = 300
  records = [var.ingress]
}

resource "aws_route53_record" "kubecost_ingress_record" {
  zone_id = data.aws_route53_zone.website.zone_id
  name    = "kubecost.htsuyoshiy.online"
  type    = "CNAME"
  ttl     = 300
  records = [var.ingress]
}

resource "aws_route53_record" "kube_ops_view_ingress_record" {
  zone_id = data.aws_route53_zone.website.zone_id
  name    = "kube-ops-view.htsuyoshiy.online"
  type    = "CNAME"
  ttl     = 300
  records = [var.ingress]
}

resource "aws_route53_record" "prometheus_ingress_record" {
  zone_id = data.aws_route53_zone.website.zone_id
  name    = "prometheus.htsuyoshiy.online"
  type    = "CNAME"
  ttl     = 300
  records = [var.ingress]
}
