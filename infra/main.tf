resource "aws_s3_bucket" "blog" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "blog" {
  bucket = aws_s3_bucket.blog.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_cloudfront_origin_access_control" "oac" {
  description                       = "Managed by Terraform"  
  name                              = "my-blog-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "blog" {
  enabled             = true
  is_ipv6_enabled     = true  # Add this - your current CF has it enabled
  default_root_object = "index.html"
  web_acl_id          = "arn:aws:wafv2:us-east-1:212712011130:global/webacl/CreatedByCloudFront-c4577059/f0966f78-9a6e-40c7-9b70-6ef4ababcd77"  

  tags = {
    Name = "Cloudwithben_blog_distribution"
  }

  origin {
    domain_name              = aws_s3_bucket.blog.bucket_regional_domain_name
    origin_id                = "http://cloud-withben-blog-2026.s3-website-eu-west-1.amazonaws.com-mjqmrbdzxbt"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "http://cloud-withben-blog-2026.s3-website-eu-west-1.amazonaws.com-mjqmrbdzxbt"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}