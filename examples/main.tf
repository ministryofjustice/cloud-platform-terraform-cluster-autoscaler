provider "aws" {
  region  = "eu-west-2"
  profile = "moj-cp"
}


module "example_cluster_autoscaler" {
  # source = ""github.com/ministryofjustice/cloud-platform-terraform-cluster-autoscaler?ref=0.2.0""
  source = "../"

  cluster_domain_name         = data.terraform_remote_state.cluster.outputs.cluster_domain_name
  eks_cluster_id              = data.terraform_remote_state.cluster.outputs.cluster_id
  eks_cluster_oidc_issuer_url = data.terraform_remote_state.cluster.outputs.cluster_oidc_issuer_url
}

