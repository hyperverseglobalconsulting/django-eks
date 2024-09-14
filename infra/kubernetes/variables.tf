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

# Declare variable for on-demand node group
variable "ng_ondemand" {
  description = "The name of the on-demand EKS node group"
  type        = string
}

# Declare variable for database username
variable "db_username" {
  description = "Username for the database"
  type        = string
}

# Declare variable for database name
variable "db_name" {
  description = "Name of the database"
  type        = string
}

