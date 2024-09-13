# Variable for AWS Region
variable "region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "us-west-1"
}

# Variable for AWS Access Key
variable "aws_access_key" {
  description = "The AWS access key used to authenticate."
  type        = string
  sensitive   = true
}

# Variable for AWS Secret Key
variable "aws_secret_access_key" {
  description = "The AWS secret key used to authenticate."
  type        = string
  sensitive   = true
}

variable "github_org" {
  description = "GitHub organization name"
  type        = string
}

variable "infra_repo_name" {
  description = "GitHub Repo name for infra"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones in the region"
  type        = list(string)
  #default     = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

variable "public_cidr_blocks" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
  #default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  #default     = "10.0.0.0/16"
}

variable "public_sg" {
  description = "Name for the Public Security Group for backend servers"
  type        = string
  #default     = "public_sg"
}

variable "bucket_name" {
  description = "The S3 bucket name"
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
}

variable "igw_name" {
  description = "The name of the Internet Gateway attached to the VPC."
  type        = string
}

variable "public_route_table_name" {
  description = "The name of the route table associated with the public subnets."
  type        = string
}

variable "ng_general_ondemand" {
  description = "The name of the node group for the Kubernetes control plane"
  type        = string
}

variable "general_ondemand_instance_types" {
  description = "A list of instance types for the general workload node group"
  type        = list(string)
}

variable "general_ondemand_max_nodes" {
  description = "The max nodes of the node group for the general workload comprising of ondemand instances"
  type        = string
}

variable "general_ondemand_desired_nodes" {
  description = "The desired nodes of the node group for the general workload comprising of ondemand instances"
  type        = string
}
