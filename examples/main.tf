provider "aws" {
  region  = "eu-west-2"
  profile = "moj-cp"
}


module "example_cluster_autoscaler" {
  # source = ""github.com/ministryofjustice/cloud-platform-terraform-cluster-autoscaler?ref=0.2.0""
  source = "../"
}

