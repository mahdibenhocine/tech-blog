terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  cloud {
    organization = "cloudwithben-org"

    workspaces {
      name = "CloudWithBenBlogDev"
    }
  }
}

provider "aws" {
  region = var.aws_region

}