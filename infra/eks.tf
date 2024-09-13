resource "aws_eks_cluster" "public" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn
  version  = "1.30"

  vpc_config {
    subnet_ids = [for subnet in aws_subnet.public : subnet.id]

    endpoint_public_access = true
    endpoint_private_access = true
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  tags = {
        Name = "${var.cluster_name}"
    }

  depends_on = [
    aws_cloudwatch_log_group.eks_cluster_logs
  ]
}

resource "aws_cloudwatch_log_group" "eks_cluster_logs" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 7

  tags = {
    Name = "${var.cluster_name}-log-group"
  }
}

resource "aws_eks_node_group" "system" {
  cluster_name    = aws_eks_cluster.public.name
  node_group_name = var.ng_ondemand
  node_role_arn   = aws_iam_role.eks_worker.arn
  subnet_ids      = [for subnet in aws_subnet.public : subnet.id]
  ami_type        = "AL2_x86_64"

  scaling_config {
    desired_size = var.ondemand_desired_nodes
    max_size     = var.ondemand_max_nodes
    min_size     = 1
  }

  instance_types = var.ondemand_instance_types
  tags = {
      Name                = "${aws_eks_cluster.public.name}-${var.ng_ondemand}-Node"
      PropagateAtLaunch   = true
    }
}
