resource "aws_iam_role" "eks_cluster" {
  name = "${var.cluster_name}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy",
    "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  ]
  tags = {
        Name = "${var.cluster_name}-eks-cluster-role"
    }
}

resource "aws_iam_role" "eks_worker" {
  name = "${var.cluster_name}-eks-worker-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
  ]
  tags = {
        Name = "${var.cluster_name}-eks-worker-role"
    }
}

resource "aws_iam_instance_profile" "eks_worker" {
  name = "eks-worker-instance-profile-${var.cluster_name}"
  role = aws_iam_role.eks_worker.name
}

data "external" "oidc_thumbprint" {
  program = ["bash", "${path.module}/get_oidc_thumbprint.sh", data.aws_region.current.name, "oidc.eks.${data.aws_region.current.name}.amazonaws.com"]
}

resource "aws_iam_openid_connect_provider" "eks_oidc" {
  url             = aws_eks_cluster.public.identity[0].oidc[0].issuer
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.external.oidc_thumbprint.result["thumbprint"]]
}

# IAM Role with OIDC Trust Relationship
resource "aws_iam_role" "eks_oidc" {
  name = "${var.cluster_name}-aws-oidc-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = aws_iam_openid_connect_provider.eks_oidc.arn
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "${aws_eks_cluster.public.identity[0].oidc[0].issuer}:sub": "system:serviceaccount:kube-system:cluster-autoscaler-aws-cluster-autoscaler"
          }
        }
      }
    ]
  })
  inline_policy {
    name   = "${var.cluster_name}-eks-cluster-autoscaler"
    policy = templatefile("${path.module}/custom_eks_cluster_autoscaler_policy.json.tpl", {
      cluster_name = var.cluster_name
    })
  }
  tags = {
        Name = "${var.cluster_name}-aws-oidc-role"
    }
}
