data "tls_certificate" "eks" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks_oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.eks.identity[0].oidc[0].issuer

  tags = {
    Name = "EKS Cluster OpenID Connect Provider - ${var.project_name}",
    Type = var.module_name
  }
}

resource "aws_iam_role" "karpenter_federated_role" {
  assume_role_policy = data.aws_iam_policy_document.karpenter_federated.json
  name               = "CustomerServiceRoleForKarpenterController"

  tags = {
    Name = "Karpenter Federated Role - ${var.project_name}",
    Type = var.module_name
  }
}

resource "aws_iam_role_policy_attachment" "karpenter_policy_attachment" {
  role       = aws_iam_role.karpenter_federated_role.name
  policy_arn = aws_iam_policy.AWSKarpenterControllerPolicy.arn
}

resource "aws_iam_role" "wp_federated_role" {
  assume_role_policy = data.aws_iam_policy_document.wp_federated.json
  name               = "CustomerServiceRoleForWordpressOffloadMedia"

  tags = {
    Name = "Wordpress Federated Role - ${var.project_name}",
    Type = var.module_name
  }
}

resource "aws_iam_role_policy_attachment" "wp_secrets_policy_attachment" {
  role       = aws_iam_role.wp_federated_role.name
  policy_arn = aws_iam_policy.AWSSecretsAccessRDSWp.arn
}

resource "aws_iam_role" "grafana_federated_role" {
  assume_role_policy = data.aws_iam_policy_document.grafana_federated.json
  name               = "CustomerServiceRoleForGrafanaSecretsAccess"

  tags = {
    Name = "Grafana Federated Role - ${var.project_name}",
    Type = var.module_name
  }
}

resource "aws_iam_role_policy_attachment" "grafana_secrets_policy_attachment" {
  role       = aws_iam_role.grafana_federated_role.name
  policy_arn = aws_iam_policy.AWSSecretsAccessGrafana.arn
}

resource "aws_iam_role" "alb_controller_role" {
  assume_role_policy = data.aws_iam_policy_document.alb_controller_federated.json
  name               = "CustomerServiceRoleForLoadBalancerController"

  tags = {
    Name = "Application Load Balancer Federated Role - ${var.project_name}",
    Type = var.module_name
  }
}

resource "aws_iam_role_policy_attachment" "alb_controller_policy_attachment" {
  role       = aws_iam_role.alb_controller_role.name
  policy_arn = aws_iam_policy.AWSLoadBalancerControllerIAMPolicy.arn
}

resource "aws_iam_role" "ebs_csi_federated_role" {
  assume_role_policy = data.aws_iam_policy_document.ebs_csi_federated.json
  name               = "CustomerServiceRoleForEKSEBSCSIDriver"

  tags = {
    Name = "EBS CSI Federated Role - ${var.project_name}",
    Type = var.module_name
  }
}

resource "aws_iam_role_policy_attachment" "ebs_csi_policy_attachment" {
  role       = aws_iam_role.ebs_csi_federated_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

resource "aws_iam_role" "efs_csi_federated_role" {
  assume_role_policy = data.aws_iam_policy_document.efs_csi_federated.json
  name               = "CustomerServiceRoleForEKSEFSCSIDriver"

  tags = {
    Name = "EFS CSI Federated Role - ${var.project_name}",
    Type = var.module_name
  }
}

resource "aws_iam_role_policy_attachment" "efs_csi_policy_attachment" {
  role       = aws_iam_role.efs_csi_federated_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
}

resource "aws_iam_role" "secrets_csi_federated_role" {
  assume_role_policy = data.aws_iam_policy_document.secrets_csi_federated.json
  name               = "CustomerServiceRoleForSecretsCSIController"

  tags = {
    Name = "Secrets CSI Federated Role - ${var.project_name}",
    Type = var.module_name
  }
}

resource "aws_iam_role_policy_attachment" "secrets_csi_policy_attachment" {
  role       = aws_iam_role.secrets_csi_federated_role.name
  policy_arn = aws_iam_policy.AWSSecretsCSIControllerIAMPolicy.arn
}