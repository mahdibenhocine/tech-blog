variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "eu-west-1"
}

variable "bucket_name" {
  description = "S3 bucket name for the blog"
  type        = string
  default     = "cloud-withben-blog-2026"
}

variable "project_name" {
  description = "Project name for tagging and identification"
  type        = string
  default     = "cloudwithben"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}