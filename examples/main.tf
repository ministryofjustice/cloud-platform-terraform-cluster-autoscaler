provider "aws" {
  region  = "eu-west-2"
  profile = "moj-cp"
}


module "example_cluster_autoscaler" {
  # source = "/Users/sablu.miah/Documents/github/cloud-platform-terraform-cluster-autoscaler"
  source = "../"

  cluster_domain_name         = data.terraform_remote_state.cluster.outputs.cluster_domain_name
  eks_cluster_id              = data.terraform_remote_state.cluster.outputs.cluster_id
  eks_cluster_oidc_issuer_url = data.terraform_remote_state.cluster.outputs.cluster_oidc_issuer_url
}

