# cloud-platform-terraform-cluster-autoscaler

[![Releases](https://img.shields.io/github/release/ministryofjustice/cloud-platform-terraform-template/all.svg?style=flat-square)](https://github.com/ministryofjustice/cloud-platform-terraform-template/releases)

This is the cluster-autoscaler terraform module

## Usage


```hcl
module "cluster_autoscaler" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-cluster-autoscaler?ref=0.0.1"

}

```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| visibility_timeout_seconds | The visibility timeout for the queue | integer | `30` | no |
| message_retention_seconds | The number of seconds Amazon SQS retains a message| integer | `345600` | no |
| max_message_size | Max message size in bytes | integer | `262144` | no |
| delay_seconds | Seconds that message will be delayed for | integer | `0` | no |
| receive_wait_time_seconds | Seconds for which a ReceiveMessage call will wait for a message to arrive | integer | `0` | no |
| kms_master_key_id | The ID of an AWS-managed customer master key | string | - | no |
| kms_data_key_reuse_period_seconds | Seconds for which Amazon SQS can reuse a data key | integer | `0` | no |
| existing_user_name | if set, adds a policy rather than creating a new IAM user | string | - | no |
| redrive_policy | if set, specifies the ARN of the "DeadLetter" queue | string | - | no |
| encrypt_sqs_kms | if set to true, it enables SSE for SQS using KMS key | string | `false` | no |


## Outputs

| Name | Description |
|------|-------------|

## Reading Material

- https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler
