##########
# Locals #
##########

locals {
  mem_pod_memory = {
    manager = "800Mi"
    live    = "1800Mi"
    live-2  = "1800Mi"
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
    live    = "10Mi"
    live-2  = "10Mi"
    default = "10Mi"
  }

  cpu_pod_cpu = {
    manager = "100m"
    live    = "100m"
    live-2  = "100m"
    default = "100m"
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
    mem_pod_memory = lookup(local.pod_memory, terraform.workspace, local.pod_memory["default"])
    mem_pod_cpu    = lookup(local.pod_cpu, terraform.workspace, local.pod_cpu["default"])
    cpu_pod_memory = lookup(local.pod_memory, terraform.workspace, local.pod_memory["default"])
    cpu_pod_cpu    = lookup(local.pod_cpu, terraform.workspace, local.pod_cpu["default"])
  })]

}

resource "helm_release" "cluster-proportional-autoscaler-memory" {
  count      = var.enable_overprovision ? 1 : 0
  name       = "cluster-proportional-autoscaler"
  chart      = "cluster-proportional-autoscaler"
  namespace  = kubernetes_namespace.overprovision[count.index].id
  repository = "https://kubernetes-sigs.github.io/cluster-proportional-autoscaler"
  version    = "1.0.1"

  values = [templatefile("${path.module}/templates/cpa-mem.yaml.tpl", {
  })]

}

resource "helm_release" "cluster-proportional-autoscaler-cpu" {
  count      = var.enable_overprovision ? 1 : 0
  name       = "cluster-proportional-autoscaler"
  chart      = "cluster-proportional-autoscaler"
  namespace  = kubernetes_namespace.overprovision[count.index].id
  repository = "https://kubernetes-sigs.github.io/cluster-proportional-autoscaler"
  version    = "1.0.1"

  values = [templatefile("${path.module}/templates/cpa-cpu.yaml.tpl", {
  })]

}