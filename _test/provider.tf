

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }
}

provider "aws" {
  region  = "us-west-1" #var.aws_region
  profile = "playground"

  default_tags {
    tags = {
      # environment = var.environment
      # app         = var.name
    }
  }
}
