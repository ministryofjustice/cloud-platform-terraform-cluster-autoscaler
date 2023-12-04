admissionController:
  enabled: false
recommender:
  enabled: true
  extraArgs:
    prometheus-address: |
      http://prometheus-operator-kube-p-prometheus.monitoring.svc.cluster.local:9090
    storage: prometheus
updater:
  enabled: false
