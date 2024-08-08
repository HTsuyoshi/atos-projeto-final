resource "null_resource" "setup_ansible" {
  provisioner "local-exec" {
    working_dir = "./ansible"
    interpreter = ["bash", "-c"]
    command     = <<-EOF
      ansible-playbook -i ${var.bastion_public_ip}, \
        --key-file ${var.bastion_config.private_key_path} \
        -e 'vpc_id=${var.vpc_id}' \
        -e 'region=${var.region}' \
        -e 'cluster_name=${var.eks_name}' \
        -e 'cluster_endpoint=${var.eks_endpoint}' \
        -e 'cluster_cidrs=${jsonencode(var.private_eks_subnet_cidrs)}' \
        -e 'db_host=${var.rds_endpoint}' \
        -e 'rds_admin_secret_arn=${var.rds_admin_secret_arn}' \
        -e 'grafana_role_arn=${var.grafana_federated_role_arn}' \
        -e 'karpenter_role_arn=${var.karpenter_federated_role_arn}' \
        -e 'karpenter_instance_profile_name=${var.karpenter_instance_profile_name}' \
        -e 'secret_csi_role_arn=${var.secret_csi_controller_federated_role_arn}' \
        -e 'aws_lb_role_arn=${var.alb_controller_federated_role_arn}' \
        -e 'wp_offload_media_role_arn=${var.wp_federated_role_arn}' \
        -e 'wp_offload_media_bucket=${var.wp_offload_media_bucket_name}' \
        -e 'wp_offload_media_cf=${var.wp_offload_media_cf}' \
        -e 'efs_id=${var.efs_id}' \
        -e 'cert_arn=${var.cert_arn}' \
        -e 'waf_wacl_arn=${var.waf_wacl_arn}' \
        playbook.yaml
      EOF

    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
  }

  triggers = {
    file_playbook             = md5(file("./ansible/playbook.yaml"))
    file_dependencies         = md5(file("./ansible/tasks/01_dependencies.yaml"))
    file_credentials          = md5(file("./ansible/tasks/02_credentials.yaml"))
    file_eks                  = md5(file("./ansible/tasks/03_eks.yaml"))
    file_controllers          = md5(file("./ansible/tasks/controllers.yaml"))
    file_crds                 = md5(file("./ansible/tasks/crds.yaml"))
    file_grafana_config       = md5(file("./ansible/tasks/grafana_config.yaml"))
    file_karpenter            = md5(file("./ansible/tasks/karpenter.yaml"))
    file_kubecost             = md5(file("./ansible/tasks/kubecost.yaml"))
    file_kubernetes_dashboard = md5(file("./ansible/tasks/kubernetes_dashboard.yaml"))
    file_metricbeat           = md5(file("./ansible/tasks/metricbeat.yaml"))
    file_metrics_server       = md5(file("./ansible/tasks/metrics_server.yaml"))
    file_output_credentials   = md5(file("./ansible/tasks/output_credentials.yaml"))
    file_prometheus_stack     = md5(file("./ansible/tasks/prometheus_stack.yaml"))
    file_wordpress            = md5(file("./ansible/tasks/wordpress.yaml"))
    file_var_endpoints        = md5(file("./ansible/vars/endpoints.yaml"))
    file_var_eks              = md5(file("./ansible/vars/general.yaml"))
  }
}