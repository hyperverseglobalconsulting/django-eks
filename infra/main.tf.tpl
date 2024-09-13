terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "${TF_VAR_bucket_name}"
    key    = "terraform/terraform.tfstate"
    region = "${TF_VAR_region}"
  }
}

provider "aws" {
  region  = "${TF_VAR_region}"
  max_retries = 10
}

provider "tls" {}

data "aws_availability_zones" "available" {}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
