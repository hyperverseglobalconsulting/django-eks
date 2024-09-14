# Define the Kubernetes namespace
resource "kubernetes_namespace" "postgresql" {
  metadata {
    name = "postgresql"
  }
}

resource "helm_release" "postgresql" {
  name       = "root-postgresql"
  namespace  = kubernetes_namespace.postgresql.metadata[0].name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "15.0.0"

  values = [
    templatefile("${path.module}/postgresql-values.yaml.tpl", {
      username              = var.db_username
      postgresql_password   = aws_ssm_parameter.postgresql_password.value
      database              = var.db_name
      nodegroup             = var.ng_ondemand
    })
  ]
}

