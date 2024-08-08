resource "aws_cloudfront_origin_access_control" "cf_origin_access_control" {
  name                              = "cf_origin_access_control"
  description                       = "Example Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "wp_static_content" {
  enabled     = true
  comment     = "${var.project_name} bucket"
  price_class = "PriceClass_100"

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  origin {
    domain_name              = aws_s3_bucket.wp_static_content.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.cf_origin_access_control.id
    origin_id                = local.s3_origin_id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  tags = {
    Name = "CloudFront - ${var.project_name}"
    Type = var.module_name
  }
}