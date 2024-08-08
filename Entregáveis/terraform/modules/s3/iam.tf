resource "aws_iam_policy" "wp_offload_media_policy" {
  name        = "WordpressS3AccessPolicy"
  description = "A policy to allow S3 access"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Action" : [
        "s3:GetBucketLocation",
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject",
        "s3:ListBucket",
        "s3:PutObjectAcl",
        "s3:GetBucketOwnershipControls",
        "s3:GetBucketPublicAccessBlock"
      ],
      "Effect" : "Allow",
      "Resource" : [
        "${aws_s3_bucket.wp_static_content.arn}/",
        "${aws_s3_bucket.wp_static_content.arn}/*",
      ]
    }]
  })

  tags = {
    Name = "Wordpress Offload Media Bucket Access Policy - ${var.project_name}",
    Type = var.module_name
  }
}

resource "aws_iam_role_policy_attachment" "offload_media_role" {
  role       = var.wp_federated_role_name
  policy_arn = aws_iam_policy.wp_offload_media_policy.arn
}