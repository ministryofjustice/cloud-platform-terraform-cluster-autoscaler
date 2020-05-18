rbac:
  create: true

sslCertPath: /etc/ssl/certs/ca-bundle.crt

cloudProvider: aws
awsRegion: eu-west-2

autoDiscovery:
  clusterName: ${cluster_name}
  enabled: true

rbac:
  create: true
  serviceAccount:
    create: true
    name: cluster-autoscaler

  serviceAccountAnnotations:
    eks.amazonaws.com/role-arn: "${eks_service_account}" 
