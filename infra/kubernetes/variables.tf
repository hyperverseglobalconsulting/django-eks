variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "aws_access_key" {
  type      = string
  sensitive = true
}

variable "aws_secret_access_key" {
  type      = string
  sensitive = true
}

variable "bucket_name" {
  description = "The S3 bucket name"
  type        = string
}

variable "kubeconfig" {
  description = "The kubeconfig file to connect the using kubectl"
  type        = string
}
