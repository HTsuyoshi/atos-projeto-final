resource "aws_iam_policy" "AWSKarpenterControllerPolicy" {
  name        = "KarpenterControllerPolicy"
  path        = "/"
  description = "Allow karpenter provision nodes"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowScopedEC2InstanceAccessActions",
        "Effect" : "Allow",
        "Action" : [
          "ec2:RunInstances",
          "ec2:CreateFleet"
        ],
        "Resource" : [
          "arn:aws:ec2:${var.region}::image/*",
          "arn:aws:ec2:${var.region}::snapshot/*",
          "arn:aws:ec2:${var.region}:*:security-group/*",
          "arn:aws:ec2:${var.region}:*:subnet/*"
        ]
      },
      {
        "Sid" : "AllowScopedEC2LaunchTemplateAccessActions",
        "Effect" : "Allow",
        "Resource" : "arn:aws:ec2:${var.region}:*:launch-template/*",
        "Action" : [
          "ec2:RunInstances",
          "ec2:CreateFleet"
        ],
        "Condition" : {
          "StringEquals" : {
            "aws:ResourceTag/kubernetes.io/cluster/${aws_eks_cluster.eks.name}" : "owned"
          },
          "StringLike" : {
            "aws:ResourceTag/karpenter.sh/nodepool" : "*"
          }
        }
      },
      {
        "Sid" : "AllowScopedEC2InstanceActionsWithTags",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ec2:${var.region}:*:fleet/*",
          "arn:aws:ec2:${var.region}:*:instance/*",
          "arn:aws:ec2:${var.region}:*:volume/*",
          "arn:aws:ec2:${var.region}:*:network-interface/*",
          "arn:aws:ec2:${var.region}:*:launch-template/*",
          "arn:aws:ec2:${var.region}:*:spot-instances-request/*"
        ],
        "Action" : [
          "ec2:RunInstances",
          "ec2:CreateFleet",
          "ec2:CreateLaunchTemplate"
        ],
        "Condition" : {
          "StringEquals" : {
            "aws:RequestTag/kubernetes.io/cluster/${aws_eks_cluster.eks.name}" : "owned"
          },
          "StringLike" : {
            "aws:RequestTag/karpenter.sh/nodepool" : "*"
          }
        }
      },
      {
        "Sid" : "AllowScopedResourceCreationTagging",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ec2:${var.region}:*:fleet/*",
          "arn:aws:ec2:${var.region}:*:instance/*",
          "arn:aws:ec2:${var.region}:*:volume/*",
          "arn:aws:ec2:${var.region}:*:network-interface/*",
          "arn:aws:ec2:${var.region}:*:launch-template/*",
          "arn:aws:ec2:${var.region}:*:spot-instances-request/*"
        ],
        "Action" : "ec2:CreateTags",
        "Condition" : {
          "StringEquals" : {
            "aws:RequestTag/kubernetes.io/cluster/${aws_eks_cluster.eks.name}" : "owned",
            "ec2:CreateAction" : [
              "RunInstances",
              "CreateFleet",
              "CreateLaunchTemplate"
            ]
          },
          "StringLike" : {
            "aws:RequestTag/karpenter.sh/nodepool" : "*"
          }
        }
      },
      {
        "Sid" : "AllowScopedResourceTagging",
        "Effect" : "Allow",
        "Resource" : "arn:aws:ec2:${var.region}:*:instance/*",
        "Action" : "ec2:CreateTags",
        "Condition" : {
          "StringEquals" : {
            "aws:ResourceTag/kubernetes.io/cluster/${aws_eks_cluster.eks.name}" : "owned"
          },
          "StringLike" : {
            "aws:ResourceTag/karpenter.sh/nodepool" : "*"
          },
          "ForAllValues:StringEquals" : {
            "aws:TagKeys" : [
              "karpenter.sh/nodeclaim",
              "Name"
            ]
          }
        }
      },
      {
        "Sid" : "AllowScopedDeletion",
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:ec2:${var.region}:*:instance/*",
          "arn:aws:ec2:${var.region}:*:launch-template/*"
        ],
        "Action" : [
          "ec2:TerminateInstances",
          "ec2:DeleteLaunchTemplate"
        ],
        "Condition" : {
          "StringEquals" : {
            "aws:ResourceTag/kubernetes.io/cluster/${aws_eks_cluster.eks.name}" : "owned"
          },
          "StringLike" : {
            "aws:ResourceTag/karpenter.sh/nodepool" : "*"
          }
        }
      },
      {
        "Sid" : "AllowRegionalReadActions",
        "Effect" : "Allow",
        "Resource" : "*",
        "Action" : [
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeImages",
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceTypeOfferings",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeLaunchTemplates",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSpotPriceHistory",
          "ec2:DescribeSubnets"
        ],
        "Condition" : {
          "StringEquals" : {
            "aws:RequestedRegion" : "${var.region}"
          }
        }
      },
      {
        "Sid" : "AllowSSMReadActions",
        "Effect" : "Allow",
        "Resource" : "arn:aws:ssm:${var.region}::parameter/aws/service/*",
        "Action" : "ssm:GetParameter"
      },
      {
        "Sid" : "AllowPricingReadActions",
        "Effect" : "Allow",
        "Resource" : "*",
        "Action" : "pricing:GetProducts"
      },
      {
        "Sid" : "AllowInterruptionQueueActions",
        "Effect" : "Allow",
        "Resource" : "${aws_sqs_queue.karpenter_interruption_queue.arn}",
        "Action" : [
          "sqs:DeleteMessage",
          "sqs:GetQueueUrl",
          "sqs:ReceiveMessage"
        ]
      },
      {
        "Sid" : "AllowPassingInstanceRole",
        "Effect" : "Allow",
        "Resource" : "${aws_iam_role.karpenter_node_role.arn}",
        "Action" : "iam:PassRole",
        "Condition" : {
          "StringEquals" : {
            "iam:PassedToService" : "ec2.amazonaws.com"
          }
        }
      },
      {
        "Sid" : "AllowScopedInstanceProfileCreationActions",
        "Effect" : "Allow",
        "Resource" : "*",
        "Action" : [
          "iam:CreateInstanceProfile"
        ],
        "Condition" : {
          "StringEquals" : {
            "aws:RequestTag/kubernetes.io/cluster/${aws_eks_cluster.eks.name}" : "owned",
            "aws:RequestTag/topology.kubernetes.io/region" : "${var.region}"
          },
          "StringLike" : {
            "aws:RequestTag/karpenter.k8s.aws/ec2nodeclass" : "*"
          }
        }
      },
      {
        "Sid" : "AllowScopedInstanceProfileTagActions",
        "Effect" : "Allow",
        "Resource" : "*",
        "Action" : [
          "iam:TagInstanceProfile"
        ],
        "Condition" : {
          "StringEquals" : {
            "aws:ResourceTag/kubernetes.io/cluster/${aws_eks_cluster.eks.name}" : "owned",
            "aws:ResourceTag/topology.kubernetes.io/region" : "${var.region}",
            "aws:RequestTag/kubernetes.io/cluster/${aws_eks_cluster.eks.name}" : "owned",
            "aws:RequestTag/topology.kubernetes.io/region" : "${var.region}"
          },
          "StringLike" : {
            "aws:ResourceTag/karpenter.k8s.aws/ec2nodeclass" : "*",
            "aws:RequestTag/karpenter.k8s.aws/ec2nodeclass" : "*"
          }
        }
      },
      {
        "Sid" : "AllowScopedInstanceProfileActions",
        "Effect" : "Allow",
        "Resource" : "*",
        "Action" : [
          "iam:AddRoleToInstanceProfile",
          "iam:RemoveRoleFromInstanceProfile",
          "iam:DeleteInstanceProfile"
        ],
        "Condition" : {
          "StringEquals" : {
            "aws:ResourceTag/kubernetes.io/cluster/${aws_eks_cluster.eks.name}" : "owned",
            "aws:ResourceTag/topology.kubernetes.io/region" : "${var.region}"
          },
          "StringLike" : {
            "aws:ResourceTag/karpenter.k8s.aws/ec2nodeclass" : "*"
          }
        }
      },
      {
        "Sid" : "AllowInstanceProfileReadActions",
        "Effect" : "Allow",
        "Resource" : "*",
        "Action" : "iam:GetInstanceProfile"
      },
      {
        "Sid" : "AllowAPIServerEndpointDiscovery",
        "Effect" : "Allow",
        "Resource" : "${aws_eks_cluster.eks.arn}",
        "Action" : "eks:DescribeCluster"
      }
    ]
  })

  tags = {
    Name = "EKS Cluster Karpenter node provisioning Policy - ${var.project_name}",
    Type = var.module_name
  }
}

resource "aws_iam_policy" "AWSSecretsAccessRDSWp" {
  name        = "SecretsAccessRDSWp"
  path        = "/"
  description = "Access RDS wordpress user secrets"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        "Resource" : [
          "${var.wp_admin_secret_arn}",
          "${var.rds_wp_secret_arn}"
        ]
      }
    ]
  })
  tags = {
    Name = "EKS Cluster Wordpress Secret Manager Access Policy - ${var.project_name}",
    Type = var.module_name
  }
}

resource "aws_iam_policy" "AWSSecretsAccessGrafana" {
  name        = "SecretsAccessGrafana"
  path        = "/"
  description = "Access RDS wordpress user secrets"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        "Resource" : [
          "${var.grafana_admin_secret_arn}"
        ]
      }
    ]
  })
  tags = {
    Name = "EKS Cluster GrafanaSecret Manager Access Policy - ${var.project_name}",
    Type = var.module_name
  }
}

resource "aws_iam_policy" "AWSSecretsCSIControllerIAMPolicy" {
  name        = "SecretsCSIControllerIAMPolicy"
  path        = "/"
  description = "Secret CSI Policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "secretsmanager:GetSecretValue",
        "Resource" : "*"
      }
    ]
  })

  tags = {
    Name = "EKS Cluster Secrets CSI Controller Policy - ${var.project_name}",
    Type = var.module_name
  }
}

resource "aws_iam_policy" "AWSLoadBalancerControllerIAMPolicy" {
  name        = "AWSLoadBalancerControllerIAMPolicyHenrique"
  path        = "/"
  description = "Application Load Balancer Controller Policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:CreateServiceLinkedRole"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "iam:AWSServiceName" : "elasticloadbalancing.amazonaws.com"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DescribeAccountAttributes",
          "ec2:DescribeAddresses",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeInternetGateways",
          "ec2:DescribeVpcs",
          "ec2:DescribeVpcPeeringConnections",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeInstances",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeTags",
          "ec2:GetCoipPoolUsage",
          "ec2:DescribeCoipPools",
          "elasticloadbalancing:DescribeLoadBalancers",
          "elasticloadbalancing:DescribeLoadBalancerAttributes",
          "elasticloadbalancing:DescribeListeners",
          "elasticloadbalancing:DescribeListenerCertificates",
          "elasticloadbalancing:DescribeSSLPolicies",
          "elasticloadbalancing:DescribeRules",
          "elasticloadbalancing:DescribeTargetGroups",
          "elasticloadbalancing:DescribeTargetGroupAttributes",
          "elasticloadbalancing:DescribeTargetHealth",
          "elasticloadbalancing:DescribeTags",
          "elasticloadbalancing:DescribeTrustStores"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "cognito-idp:DescribeUserPoolClient",
          "acm:ListCertificates",
          "acm:DescribeCertificate",
          "iam:ListServerCertificates",
          "iam:GetServerCertificate",
          "waf-regional:GetWebACL",
          "waf-regional:GetWebACLForResource",
          "waf-regional:AssociateWebACL",
          "waf-regional:DisassociateWebACL",
          "wafv2:GetWebACL",
          "wafv2:GetWebACLForResource",
          "wafv2:AssociateWebACL",
          "wafv2:DisassociateWebACL",
          "shield:GetSubscriptionState",
          "shield:DescribeProtection",
          "shield:CreateProtection",
          "shield:DeleteProtection"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupIngress"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateSecurityGroup"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateTags"
        ],
        "Resource" : "arn:aws:ec2:*:*:security-group/*",
        "Condition" : {
          "StringEquals" : {
            "ec2:CreateAction" : "CreateSecurityGroup"
          },
          "Null" : {
            "aws:RequestTag/elbv2.k8s.aws/cluster" : "false"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateTags",
          "ec2:DeleteTags"
        ],
        "Resource" : "arn:aws:ec2:*:*:security-group/*",
        "Condition" : {
          "Null" : {
            "aws:RequestTag/elbv2.k8s.aws/cluster" : "true",
            "aws:ResourceTag/elbv2.k8s.aws/cluster" : "false"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupIngress",
          "ec2:DeleteSecurityGroup"
        ],
        "Resource" : "*",
        "Condition" : {
          "Null" : {
            "aws:ResourceTag/elbv2.k8s.aws/cluster" : "false"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "elasticloadbalancing:CreateLoadBalancer",
          "elasticloadbalancing:CreateTargetGroup"
        ],
        "Resource" : "*",
        "Condition" : {
          "Null" : {
            "aws:RequestTag/elbv2.k8s.aws/cluster" : "false"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "elasticloadbalancing:CreateListener",
          "elasticloadbalancing:DeleteListener",
          "elasticloadbalancing:CreateRule",
          "elasticloadbalancing:DeleteRule"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "elasticloadbalancing:AddTags",
          "elasticloadbalancing:RemoveTags"
        ],
        "Resource" : [
          "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
          "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
          "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*"
        ],
        "Condition" : {
          "Null" : {
            "aws:RequestTag/elbv2.k8s.aws/cluster" : "true",
            "aws:ResourceTag/elbv2.k8s.aws/cluster" : "false"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "elasticloadbalancing:AddTags",
          "elasticloadbalancing:RemoveTags"
        ],
        "Resource" : [
          "arn:aws:elasticloadbalancing:*:*:listener/net/*/*/*",
          "arn:aws:elasticloadbalancing:*:*:listener/app/*/*/*",
          "arn:aws:elasticloadbalancing:*:*:listener-rule/net/*/*/*",
          "arn:aws:elasticloadbalancing:*:*:listener-rule/app/*/*/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "elasticloadbalancing:ModifyLoadBalancerAttributes",
          "elasticloadbalancing:SetIpAddressType",
          "elasticloadbalancing:SetSecurityGroups",
          "elasticloadbalancing:SetSubnets",
          "elasticloadbalancing:DeleteLoadBalancer",
          "elasticloadbalancing:ModifyTargetGroup",
          "elasticloadbalancing:ModifyTargetGroupAttributes",
          "elasticloadbalancing:DeleteTargetGroup"
        ],
        "Resource" : "*",
        "Condition" : {
          "Null" : {
            "aws:ResourceTag/elbv2.k8s.aws/cluster" : "false"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "elasticloadbalancing:AddTags"
        ],
        "Resource" : [
          "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
          "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
          "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*"
        ],
        "Condition" : {
          "StringEquals" : {
            "elasticloadbalancing:CreateAction" : [
              "CreateTargetGroup",
              "CreateLoadBalancer"
            ]
          },
          "Null" : {
            "aws:RequestTag/elbv2.k8s.aws/cluster" : "false"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "elasticloadbalancing:RegisterTargets",
          "elasticloadbalancing:DeregisterTargets"
        ],
        "Resource" : "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "elasticloadbalancing:SetWebAcl",
          "elasticloadbalancing:ModifyListener",
          "elasticloadbalancing:AddListenerCertificates",
          "elasticloadbalancing:RemoveListenerCertificates",
          "elasticloadbalancing:ModifyRule"
        ],
        "Resource" : "*"
      }
    ]
  })

  tags = {
    Name = "EKS Load Balancer Controller Policy - ${var.project_name}",
    Type = var.module_name
  }
}

