# cloud-platform-terraform-cluster-autoscaler

[![Releases](https://img.shields.io/github/release/ministryofjustice/cloud-platform-terraform-template/all.svg?style=flat-square)](https://github.com/ministryofjustice/cloud-platform-terraform-template/releases)

This is the cluster-autoscaler terraform module

## Usage


```hcl
module "cluster_autoscaler" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-cluster-autoscaler?ref=0.0.1"

  cluster_domain_name         = data.terraform_remote_state.cluster.outputs.cluster_domain_name
  eks_cluster_id              = data.terraform_remote_state.cluster.outputs.cluster_id
  eks_cluster_oidc_issuer_url = data.terraform_remote_state.cluster.outputs.cluster_oidc_issuer_url
}
```
## Inputs

| Name                        | Description | Type | Default | Required |
|---------------------------  |-------------|:----:|:-----:|:-----:|
| enable_cluster_autoscaler   | Enable or not cluster autoscaler module | bool | true | no |
| eks_cluster_id              | The EKS cluster ID used by autoscaler's IAM Policy | string | "" | yes |
| eks_cluster_oidc_issuer_url | If EKS variable is set to true this is going to be used when we create the IAM OIDC role | string | "" | no |
| cluster_domain_name         | cluster_domain_name | string |  | yes |


## Outputs

| Name | Description |
|------|-------------|

## Reading Material

- https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler
