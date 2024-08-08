locals {
  s3_origin_id = "static_content_origin_id"
}

resource "aws_s3_bucket" "wp_static_content" {
  bucket_prefix = var.bucket.prefix
  force_destroy = var.bucket.force_destroy

  tags = {
    Name = "Static content - ${var.project_name}"
    Type = var.module_name
  }
}

resource "aws_s3_bucket_public_access_block" "unblock_public_access" {
  bucket = aws_s3_bucket.wp_static_content.bucket

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "allow_access_from_cloud_front" {
  bucket = aws_s3_bucket.wp_static_content.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Sid" : "AllowCloudFrontServicePrincipalReadOnly",
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "cloudfront.amazonaws.com"
      },
      "Action" : "s3:GetObject",
      "Resource" : "${aws_s3_bucket.wp_static_content.arn}/*",
      "Condition" : {
        "StringEquals" : {
          "AWS:SourceArn" : "${aws_cloudfront_distribution.wp_static_content.arn}"
        }
      }
      },
      {
        "Sid" : "AllowWordpressUploadStaticContent",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "${var.wp_federated_role_arn}"
        },
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:PutObjectAcl",
          "s3:GetBucketLocation",
          "s3:GetBucketOwnershipControls",
          "s3:GetBucketPublicAccessBlock"
        ],
        "Resource" : [
          "${aws_s3_bucket.wp_static_content.arn}/*",
          "${aws_s3_bucket.wp_static_content.arn}"
        ]
    }]
  })
}