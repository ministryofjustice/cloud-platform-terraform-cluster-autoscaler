resource "helm_release" "vpa" {
  count = var.enable_vpa ? 1 : 0

  name       = "vpa"
  repository = "https://charts.fairwinds.com/stable"
  chart      = "vpa"

  namespace  = "kube-system"
  version    = "3.0.2"

  values = [templatefile("${path.module}/templates/vpa.yaml.tpl", {
  })]

}

resource "helm_release" "goldilocks" {
  count = var.enable_goldilocks ? 1 : 0

  name = "goldilocks"
  repository = "https://charts.fairwinds.com/stable"
  chart = "goldilocks"

  namespace = "kube-system"
  version  = "8.0.0"
}
