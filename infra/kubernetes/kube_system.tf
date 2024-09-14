data "kubernetes_namespace" "kube_system" {
  metadata {
    name = "kube-system"
  }
}
