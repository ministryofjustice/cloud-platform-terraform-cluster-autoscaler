##########
# Locals #
##########

locals {
  memory_overprovision = {
    manager = "800Mi"
    live    = var.live_memory_request # To enable tuning via components module call
    live-2  = var.live_memory_request
    default = "100Mi"
  }

  cpu_overprovision = {
    manager = "10m"
    live    = var.live_cpu_request
    live-2  = var.live_cpu_request
    default = "10m"
  }

}

resource "kubernetes_namespace" "overprovision" {
  count = var.enable_overprovision ? 1 : 0
  metadata {
    name = "overprovision"

    labels = {
      "name"                                           = "overprovision"
      "cloud-platform.justice.gov.uk/environment-name" = "production"
      "cloud-platform.justice.gov.uk/is-production"    = "true"
      "pod-security.kubernetes.io/enforce"             = "restricted"
    }

    annotations = {
      "cloud-platform.justice.gov.uk/application"   = "overprovision"
      "cloud-platform.justice.gov.uk/business-unit" = "Platforms"
      "cloud-platform.justice.gov.uk/owner"         = "Cloud Platform: platforms@digital.justice.gov.uk"
      "cloud-platform.justice.gov.uk/source-code"   = "https://github.com/ministryofjustice/cloud-platform-terraform-cluster-autoscaler/"
      "cloud-platform.justice.gov.uk/slack-channel" = "cloud-platform"
      "cloud-platform-out-of-hours-alert"           = "true"
    }
  }
}

resource "helm_release" "cluster-overprovisioner" {
  count      = var.enable_overprovision ? 1 : 0
  name       = "cluster-overprovisioner"
  chart      = "cluster-overprovisioner"
  namespace  = kubernetes_namespace.overprovision[count.index].id
  repository = "https://charts.deliveryhero.io/"
  version    = "0.7.11"

  values = [templatefile("${path.module}/templates/cluster-overprovisioner.yaml.tpl", {
    memory_overprovision = lookup(local.memory_overprovision, terraform.workspace, local.memory_overprovision["default"])
    cpu_overprovision    = lookup(local.cpu_overprovision, terraform.workspace, local.cpu_overprovision["default"])
  })]

}

resource "helm_release" "cluster-proportional-autoscaler-memory" {
  count      = var.enable_overprovision ? 1 : 0
  name       = "cluster-proportional-autoscaler-memory"
  chart      = "cluster-proportional-autoscaler"
  namespace  = kubernetes_namespace.overprovision[count.index].id
  repository = "https://kubernetes-sigs.github.io/cluster-proportional-autoscaler"
  version    = "1.1.0"

  values = [templatefile("${path.module}/templates/cpa-mem.yaml.tpl", {
  })]

}

resource "helm_release" "cluster-proportional-autoscaler-cpu" {
  count      = var.enable_overprovision ? 1 : 0
  name       = "cluster-proportional-autoscaler-cpu"
  chart      = "cluster-proportional-autoscaler"
  namespace  = kubernetes_namespace.overprovision[count.index].id
  repository = "https://kubernetes-sigs.github.io/cluster-proportional-autoscaler"
  version    = "1.1.0"

  values = [templatefile("${path.module}/templates/cpa-cpu.yaml.tpl", {
  })]

}
