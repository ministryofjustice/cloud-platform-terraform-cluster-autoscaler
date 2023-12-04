resource "helm_release" "vpa" {
  name       = "vpa"
  repository = "https://charts.fairwinds.com/stable"
  chart      = "fairwinds-stable/vpa"

  namespace  = "kube-system"
  version    = "0.14.0"

  values = [templatefile("${path.module}/templates/vpa.yaml.tpl", {
  })]

}
