# Deploy metrics-server using Helm
resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "metrics-server"
  namespace  = data.kubernetes_namespace.kube_system.metadata.0.name
  timeout    = 900

  # Reference the external values file
  values = [templatefile("${path.module}/metrics-server-values.yaml.tpl", {
    nodegroup = aws_eks_node_group.ondemand.node_group_name
  })]
}

output "metrics_server_status" {
  value       = helm_release.metrics_server.status
  description = "The status of the Metrics Server Helm release."
}
