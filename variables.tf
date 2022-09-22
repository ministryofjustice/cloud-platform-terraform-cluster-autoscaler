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

variable "enable_cluster_autoscaler" {
  description = "Enable or disbale creation of cluster autoscaler module"
  type        = bool
  default     = true
}

variable "enable_overprovision" {
  description = "Enable or disbale creation of overprovisioner"
  type        = bool
  default     = true
}