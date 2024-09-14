resource "helm_release" "ebs_csi_driver" {
  provider   = helm
  name       = "ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  namespace  = "kube-system"

  values = [
    templatefile("${path.module}/ebs-csi-values.yaml.tpl", {
      nodegroup = var.ng_ondemand
    })
  ]
}
