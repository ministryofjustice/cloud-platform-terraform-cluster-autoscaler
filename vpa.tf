resource "helm_release" "vpa" {
  name       = "vpa"
  repository = "https://charts.fairwinds.com/stable"
  chart      = "fairwinds-stable/vpa"

  namespace  = "kube-system"
  version    = "3.0.2"

  values = [templatefile("${path.module}/templates/vpa.yaml.tpl", {
  })]

}
