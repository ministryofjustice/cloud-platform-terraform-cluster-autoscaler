provider "aws" {
  region  = "eu-west-2"
  profile = "moj-cp"
}


module "example_cluster_autoscaler" {
  # source = ""github.com/ministryofjustice/cloud-platform-terraform-cluster-autoscaler?ref=0.2.0""
  source = "../"

  cluster_domain_name         = "example_cluster_autoscaler.cloud-platform.service.justice.gov.uk"
  eks_cluster_id              = "example_cluster_autoscaler"
  eks_cluster_oidc_issuer_url = "oidc_example_cluster_autoscaler.cloud-platform.service.justice.gov.uk"
}

