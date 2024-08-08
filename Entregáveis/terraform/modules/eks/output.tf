output "eks_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "eks_arn" {
  value = aws_eks_cluster.eks.arn
}

output "wp_federated_role_name" {
  value = aws_iam_role.wp_federated_role.name
}

output "wp_federated_role_arn" {
  value = aws_iam_role.wp_federated_role.arn
}
output "karpenter_instance_profile_name" {
  value = aws_iam_instance_profile.karpenter_instance_profile.name
}

output "karpenter_federated_role_arn" {
  value = aws_iam_role.karpenter_federated_role.arn
}

output "grafana_federated_role_arn" {
  value = aws_iam_role.grafana_federated_role.arn
}

output "secret_csi_federated_role_arn" {
  value = aws_iam_role.secrets_csi_federated_role.arn
}

output "alb_controller_federated_role_arn" {
  value = aws_iam_role.alb_controller_role.arn
}