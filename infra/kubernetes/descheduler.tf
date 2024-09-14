resource "helm_release" "descheduler" {
  name       = "ctrl-descheduler"
  repository = "https://kubernetes-sigs.github.io/descheduler"
  chart      = "descheduler"
  namespace  = "kube-system"

  values = [templatefile("${path.module}/descheduler-values.yaml.tpl", {
    nodegroup = aws_eks_node_group.ondemand.node_group_name
  })]
}
