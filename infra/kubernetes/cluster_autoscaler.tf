resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  namespace  = "kube-system"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"

  values = [templatefile("${path.module}/cluster-autoscaler-values.yaml.tpl", {
    cluster_name = data.aws_eks_cluster.public.name
    aws_region   = data.aws_region.current.name
    nodegroup    = var.ng_ondemand
    # Uncomment and provide actual value if role_arn is needed
    # role_arn = data.aws_caller_identity.current.account_id
  })]
}
