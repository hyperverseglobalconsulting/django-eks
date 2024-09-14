terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.17.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.1"
    }
  }

  backend "s3" {
    bucket  = "${TF_VAR_bucket_name}"
    key     = "terraform/kubernetes.tfstate"
    region  = "${TF_VAR_region}"
  }
}

provider "aws" {
  region  = "${TF_VAR_region}"
  max_retries = 10
}

# Kubernetes Provider Setup
provider "kubernetes" {
  config_path = var.kubeconfig
}

# Helm Provider Setup
provider "helm" {
  kubernetes {
    config_path = var.kubeconfig
  }
}

provider "kubectl" {
  config_path = var.kubeconfig
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
