
cloudProvider: aws
awsRegion: eu-west-2

image:
  # image.repository -- Image repository
  repository: registry.k8s.io/autoscaling/cluster-autoscaler
  # image.tag -- Image tag
  tag: ""

autoDiscovery:
  clusterName: ${cluster_name}

extraArgs:
  logtostderr: true
  stderrthreshold: info
  v: 4
  scale-down-utilization-threshold: 0.1
  ignore-daemonsets-utilization: true

rbac:
  create: true
  pspEnabled: false
  serviceAccount:
    create: true
    name: cluster-autoscaler
    annotations:
      eks.amazonaws.com/role-arn: "${eks_service_account}" 
  

## Are you using Prometheus Operator?
serviceMonitor:
  # serviceMonitor.enabled -- If true, creates a Prometheus Operator ServiceMonitor.
  enabled: "true"
  # serviceMonitor.interval -- Interval that Prometheus scrapes Cluster Autoscaler metrics.
  interval: 10s
  # serviceMonitor.namespace -- Namespace which Prometheus is running in.
  namespace: monitoring
  ## [Prometheus Selector Label](https://github.com/helm/charts/tree/master/stable/prometheus-operator#prometheus-operator-1)
  ## [Kube Prometheus Selector Label](https://github.com/helm/charts/tree/master/stable/prometheus-operator#exporters)
  # serviceMonitor.selector -- Default to kube-prometheus install (CoreOS recommended), but should be set according to Prometheus install.
  selector:
    release: prometheus-operator
  # serviceMonitor.path -- The path to scrape for metrics; autoscaler exposes `/metrics` (this is standard)
  path: /metrics
  # serviceMonitor.annotations -- Annotations to add to service monitor
  annotations: {}
