##########
# Locals #
##########

locals {
  mem_pod_memory = {
    manager = "800Mi"
    live    = var.live_memory_request  # To enable tuning via components module call
    live-2  = var.live_memory_request
    default = "100Mi"
  }

  mem_pod_cpu = {
    manager = "2m"
    live    = "2m"
    live-2  = "2m"
    default = "2m"
  }

  cpu_pod_memory = {
    manager = "10Mi"
    live    = var.live_cpu_request # To enable tuning via components module call
    live-2  = var.live_cpu_request
    default = var.live_cpu_request
  }

  cpu_pod_cpu = {
    manager = "10m"
    live    = var.live_cpu_request
    live-2  = var.live_cpu_request
    default = var.live_cpu_request
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
  version    = "0.7.1"

  values = [templatefile("${path.module}/templates/cluster-overprovisioner.yaml.tpl", {
    mem_pod_memory = lookup(local.mem_pod_memory, terraform.workspace, local.mem_pod_memory["default"])
    mem_pod_cpu    = lookup(local.mem_pod_cpu, terraform.workspace, local.mem_pod_cpu["default"])
    cpu_pod_memory = lookup(local.cpu_pod_memory, terraform.workspace, local.cpu_pod_memory["default"])
    cpu_pod_cpu    = lookup(local.cpu_pod_cpu, terraform.workspace, local.cpu_pod_cpu["default"])
  })]

}

resource "helm_release" "cluster-proportional-autoscaler-memory" {
  count      = var.enable_overprovision ? 1 : 0
  name       = "cluster-proportional-autoscaler-memory"
  chart      = "cluster-proportional-autoscaler"
  namespace  = kubernetes_namespace.overprovision[count.index].id
  repository = "https://kubernetes-sigs.github.io/cluster-proportional-autoscaler"
  version    = "1.0.1"

  values = [templatefile("${path.module}/templates/cpa-mem.yaml.tpl", {
  })]

}

resource "helm_release" "cluster-proportional-autoscaler-cpu" {
  count      = var.enable_overprovision ? 1 : 0
  name       = "cluster-proportional-autoscaler-cpu"
  chart      = "cluster-proportional-autoscaler"
  namespace  = kubernetes_namespace.overprovision[count.index].id
  repository = "https://kubernetes-sigs.github.io/cluster-proportional-autoscaler"
  version    = "1.0.1"

  values = [templatefile("${path.module}/templates/cpa-cpu.yaml.tpl", {
  })]

}