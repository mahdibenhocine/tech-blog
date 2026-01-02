output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.blog.id
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.blog.domain_name
}
