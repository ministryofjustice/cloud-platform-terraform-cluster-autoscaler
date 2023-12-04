variable "cluster_domain_name" {
  description = "The cluster domain used for externalDNS annotations and certmanager"
}

variable "eks_cluster_oidc_issuer_url" {
  description = "If EKS variable is set to true this is going to be used when we create the IAM OIDC role"
  type        = string
  default     = ""
}

variable "eks_cluster_id" {
  description = "The EKS cluster ID used by the autoscaler"
}

variable "enable_overprovision" {
  description = "Enable or disable creation of overprovisioner"
  type        = bool
  default     = true
}

variable "live_memory_request" {
  description = "Overprovisioner memory request for live pods"
  type        = string
  default     = "1800Mi"
}

variable "live_cpu_request" {
  description = "Overprovisioner cpu request for live pods"
  type        = string
  default     = "200m"
}

variable "enable_vpa" {
  description = "Enable or disable creation of vpa"
  type = bool
  default = false
}

variable "enable_goldilocks" {
  description = "Enable or disbale creation of goldilocks"
  type = bool
  default = false
}
