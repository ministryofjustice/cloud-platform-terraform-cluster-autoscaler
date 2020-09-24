
cloudProvider: aws
awsRegion: eu-west-2

image:
  # image.repository -- Image repository
  repository: us.gcr.io/k8s-artifacts-prod/autoscaling/cluster-autoscaler
  # image.tag -- Image tag
  tag: v1.16.6

autoDiscovery:
  clusterName: ${cluster_name}

rbac:
  create: true
  serviceAccount:
    create: true
    name: cluster-autoscaler
    annotations:
      eks.amazonaws.com/role-arn: "${eks_service_account}" 
  

