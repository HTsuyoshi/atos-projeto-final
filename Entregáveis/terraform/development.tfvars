region       = "us-east-2"
project_name = "Wordpress EKS"

net_cidr = {
  vpc = "192.168.0.0/16",
  eks_subnet = [
    "192.168.0.0/18",
    "192.168.64.0/18",
  ],
  eks_subnet_mysql = [
    "192.168.0.0/255.255.192.0",
    "192.168.64.0/255.255.192.0",
  ],
  rds_subnet = [
    "192.168.128.0/24",
    "192.168.129.0/24",
  ],
  pub_subnet = [
    "192.168.130.0/24",
    "192.168.131.0/24",
  ]
}

eks = {
  name                = "wordpress-eks"
  version             = "1.30"
  private_endpoint    = true
  public_endpoint     = false
  public_access_cidrs = ["0.0.0.0/32"]
  control_plane_cidr  = "10.100.0.0/16"
}

eks_addons_version = {
  "kube-proxy"         = "v1.29.0-eksbuild.1",
  "vpc-cni"            = "v1.16.0-eksbuild.1",
  "coredns"            = "v1.11.1-eksbuild.9",
  "aws-ebs-csi-driver" = "v1.32.0-eksbuild.1"
  "aws-efs-csi-driver" = "v2.0.5-eksbuild.1"
}

eks_node_group = {
  name            = "eks_node_group"
  disk_size       = 20
  capacity_type   = "ON_DEMAND"
  instance_types  = ["t3.small"]
  desired_size    = 2
  max_size        = 3
  min_size        = 2
  max_unavailable = 1
}

bastion_config = {
  instance_type    = "t3.micro"
  volume_type      = "standard"
  volume_size      = 8
  source_cidr      = "200.53.194.79/32"
  public_key_path  = "~/.ssh/ec2_aws.pub"
  private_key_path = "~/.ssh/ec2_aws"
}

mariadb = {
  engine                              = "mariadb"
  engine_version                      = "10.11.6"
  instance_class                      = "db.t3.micro"
  allocated_storage                   = 20
  max_allocated_storage               = 40
  storage_encrypted                   = false
  family                              = ""
  db_name                             = "wordpress"
  db_username                         = "wordpress_user"
  manage_master_user_password         = true
  port                                = "3306"
  skip_final_snapshot                 = true
  publicly_accessible                 = false
  multi_az                            = false
  iam_database_authentication_enabled = false
}

bucket = {
  prefix        = "wordpress-eks-static-content-"
  force_destroy = true
}

default_tags = {
  Application = "Wordpress EKS",
  Terraform   = "true",
  Environment = "Development",
  "Owned by"  = "Henrique Yara",
  Name        = "",
  Type        = "",
}
