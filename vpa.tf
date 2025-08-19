
resource "helm_release" "vpa" {
  count      = var.enable_vpa_recommender ? 1 : 0
  name       = "vpa"
  repository = "https://charts.fairwinds.com/stable"
  chart      = "vpa"
  version    = "4.8.1"
  namespace  = "kube-system"
  create_namespace = false

  set {
    name  = "recommender.enabled"
    value = "true"
  }
  set {
    name  = "updater.enabled"
    value = "false"
  }
  set {
    name  = "admissionController.enabled"
    value = "false"
  }
}
