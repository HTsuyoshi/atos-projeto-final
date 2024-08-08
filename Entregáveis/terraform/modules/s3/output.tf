output "bucket_name" {
  value = aws_s3_bucket.wp_static_content.bucket
}

output "cf_domain_name" {
  value = aws_cloudfront_distribution.wp_static_content.domain_name
}
