affinity: {}
config: 
#  ladder:
#    coresToReplicas:
#      - [ 1, 1 ]
#      - [ 64, 3 ]
#      - [ 512, 5 ]
#      - [ 1024, 7 ]
#      - [ 2048, 10 ]
#      - [ 4096, 15 ]
#    nodesToReplicas:
#      - [ 1, 1 ]
#      - [ 2, 2 ]
  linear:
    nodesPerReplica: 1
    min: 1
    max: 100
    preventSinglePointFailure: true
    includeUnschedulableNodes: true
image:
  repository: registry.k8s.io/cpa/cluster-proportional-autoscaler
  pullPolicy: IfNotPresent
  tag:
imagePullSecrets: []
fullnameOverride:
nameOverride: memory
nodeSelector: {}
options:
  alsoLogToStdErr: "true"
  logBacktraceAt: 0
  logDir: ""
  #  --v=0: log level for V logs
  logLevel: 0
  # Defaulting to true limits use of ephemeral storage
  logToStdErr: true
  maxSyncFailures:
  namespace: overprovision
  nodeLabels: {}
  #    label1: value1
  #    label2: value2
  pollPeriodSeconds: 10
  stdErrThreshold: 2
  target: "deployment/cluster-overprovisioner-memory"
  vmodule:
podAnnotations: {}
podSecurityContext: {}
# fsGroup: 2000
replicaCount: 1
resources: {}
  # We usually recommend not to specify default resources and to leave this as a conscious
  # choice for the user. This also increases chances charts run on environments with little
  # resources, such as Minikube. If you do want to specify resources, uncomment the following
  # lines, adjust them as necessary, and remove the curly braces after 'resources:'.
  # limits:
  #   cpu: 100m
  #   memory: 128Mi
  # requests:
  #   cpu: 100m
#   memory: 128Mi
securityContext: {}
  # capabilities:
  #   drop:
  #   - ALL
  # readOnlyRootFilesystem: true
  # runAsNonRoot: true
# runAsUser: 1000
serviceAccount:
  create: true
  annotations: {}
  # The name of the service account to use.
  # If not set and create is true, a name is generated using the fullname template
  # If set and create is false, no service account will be created and the expectation is that the provided service account already exists or it will use the "default" service account
  name:
tolerations: []
