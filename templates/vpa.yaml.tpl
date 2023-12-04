recommender:
  # recommender.enabled -- If true, the vpa recommender component will be installed.
  enabled: true
  # recommender.extraArgs -- A set of key-value flags to be passed to the recommender
  extraArgs:
    pod-recommendation-min-cpu-millicores: 15
    pod-recommendation-min-memory-mb: 100
    prometheus-address: http://kube-prometheus-prometheus.monitoring:9090
    storage: prometheus
    prometheus-cadvisor-job-name: kubelet
    pod-namespace-label: namespace
    pod-name-label: pod
    container-namespace-label: namespace
    container-pod-name-label: pod
    container-name-label: container

  replicaCount: 1
  # recommender.maxUnavailable -- This is the max unavailable setting for the pod disruption budget
  maxUnavailable: 1
  # recommender.resources -- The resources block for the recommender pod
  resources:
    limits:
      cpu: 200m
      memory: 1000Mi
    requests:
      cpu: 50m
      memory: 500Mi

updater:
  # updater.enabled -- If true, the updater component will be deployed
  enabled: false
  # updater.extraArgs -- A key-value map of flags to pass to the updater
  extraArgs: {}
  replicaCount: 1
  # updater.maxUnavailable -- This is the max unavailable setting for the pod disruption budget
  maxUnavailable: 1
  # updater.resources -- The resources block for the updater pod
  resources:
    limits:
      cpu: 200m
      memory: 1000Mi
    requests:
      cpu: 50m
      memory: 500Mi

admissionController:
  # admissionController.enabled -- If true, will install the admission-controller component of vpa
  enabled: false
  # admissionController.generateCertificate -- If true and admissionController is enabled, a pre-install hook will run to create the certificate for the webhook
  generateCertificate: true
  certGen:
    # admissionController.certGen.env -- Additional environment variables to be added to the certgen container. Format is KEY: Value format
    env: {}
  # admissionController.cleanupOnDelete -- If true, a post-delete job will remove the mutatingwebhookconfiguration and the tls secret for the admission controller
  cleanupOnDelete: true
  replicaCount: 1
  # admissionController.resources -- The resources block for the admission controller pod
  resources:
    limits:
      cpu: 200m
      memory: 500Mi
    requests:
      cpu: 50m
      memory: 200Mi
