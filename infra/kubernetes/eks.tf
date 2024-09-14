data "aws_eks_cluster" "public" {
  name = var.cluster_name
}
