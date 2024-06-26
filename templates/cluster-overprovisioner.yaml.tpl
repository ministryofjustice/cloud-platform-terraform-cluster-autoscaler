# podSecurityContext -- Pod security context object
podSecurityContext: 
  runAsUser: 1235

priorityClassOverprovision:
  # priorityClassOverprovision.name -- Name of the overprovision priorityClass
  name: overprovisioning
  # priorityClassOverprovision.value -- Priority value of the overprovision priorityClass
  value: -1

priorityClassDefault:
  # priorityClassDefault.enabled -- If true, enable default priorityClass
  enabled: false
  # priorityClassDefault.name -- Name of the default priorityClass
  name: default
  # priorityClassDefault.value -- Priority value of the default priorityClass
  value: 0

image:
  # image.repository -- Image repository
  repository: registry.k8s.io/pause
  # image.tag -- Image tag
  # @default -- `.Chart.AppVersion`
  tag: ""
  # image.pullPolicy -- Container pull policy
  pullPolicy: IfNotPresent

  ## Optionally specify an array of imagePullSecrets.
  ## Secrets must be manually created in the namespace.
  ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
  ##
  ## image.pullSecrets -- Image pull secrets
  # pullSecrets:
  #   - myRegistrKeySecretName

# nameOverride -- Override the name of the chart
nameOverride: ""

# fullnameOverride -- Override the fullname of the chart
fullnameOverride: ""

# deployments -- Define optional additional deployments - A default deployment is included by default
# @default -- []
deployments:
  # deployments[0].name -- Default Deployment - Name for additional deployments (will be added as label cluster-over-provisioner-name, so you can match it with affinity rules)
  
  # Memory overprovisioner deployment
  - name: memory
    # deployments[0].annotations -- Default Deployment - Annotations to add to the deployment
    annotations: {}
    # deployments[0].podAnnotations -- Default Deployment - Annotations to add to the pods
    podAnnotations: {}
    # deployments[0].replicaCount -- Default Deployment - Number of replicas
    replicaCount: 1
    # deployments[0].nodeSelector -- Default Deployment - Node labels for pod assignment
    nodeSelector: {}
    resources:
      limits:
        # deployments[0].resources.limits.cpu -- Default Deployment - CPU limit for the overprovision pods
        cpu: "2m"
        # deployments[0].resources.limits.memory -- Default Deployment - Memory limit for the overprovision pods
        memory: ${ memory_overprovision }
      requests:
        # deployments[0].resources.requests.cpu -- Default Deployment - CPU requested for the overprovision pods
        cpu: "2m"
        # deployments[0].resources.requests.memory -- Default Deployment - Memory requested for the overprovision pods
        memory: ${ memory_overprovision }
    # deployments[0].tolerations -- Default Deployment - Optional deployment tolerations
    tolerations: []
    # deployments[0].affinity -- Default Deployment - Map of node/pod affinities
    affinity: {}
    # deployments[0].labels -- Default Deployment - Optional labels tolerations
    labels: {}
    # deployments[0].topologySpreadConstraints -- Default Deployment - Optional topology spread constraints
    topologySpreadConstraints: []
      # - maxSkew: 1
      #   topologyKey: failure-domain.beta.kubernetes.io/zone
      #   whenUnsatisfiable: DoNotSchedule
      # - maxSkew: 1
      #   topologyKey: kubernetes.io/hostname
      #   whenUnsatisfiable: ScheduleAnyway
    # deployments[0].name -- Default Deployment - Name for additional deployments (will be added as label cluster-over-provisioner-name, so you can match it with affinity rules)
  
  # CPU Overprovisioner deployment
  - name: cpu
    # deployments[0].annotations -- Default Deployment - Annotations to add to the deployment
    annotations: {}
    # deployments[0].podAnnotations -- Default Deployment - Annotations to add to the pods
    podAnnotations: {}
    # deployments[0].replicaCount -- Default Deployment - Number of replicas
    replicaCount: 1
    # deployments[0].nodeSelector -- Default Deployment - Node labels for pod assignment
    nodeSelector: {}
    resources:
      limits:
        # deployments[0].resources.limits.cpu -- Default Deployment - CPU limit for the overprovision pods
        cpu: ${ cpu_overprovision }
        # deployments[0].resources.limits.memory -- Default Deployment - Memory limit for the overprovision pods
        memory: "10Mi"
      requests:
        # deployments[0].resources.requests.cpu -- Default Deployment - CPU requested for the overprovision pods
        cpu: ${ cpu_overprovision }
        # deployments[0].resources.requests.memory -- Default Deployment - Memory requested for the overprovision pods
        memory: "10Mi"
    # deployments[0].tolerations -- Default Deployment - Optional deployment tolerations
    tolerations: []
    # deployments[0].affinity -- Default Deployment - Map of node/pod affinities
    affinity: {}
    # deployments[0].labels -- Default Deployment - Optional labels tolerations
    labels: {}
    # deployments[0].topologySpreadConstraints -- Default Deployment - Optional topology spread constraints
    topologySpreadConstraints: []
      # - maxSkew: 1
      #   topologyKey: failure-domain.beta.kubernetes.io/zone
      #   whenUnsatisfiable: DoNotSchedule
      # - maxSkew: 1
      #   topologyKey: kubernetes.io/hostname
      #   whenUnsatisfiable: ScheduleAnyway

  # Daemonset Overprovisioner deployment - This does not create a new daemonset but mimics other overprovisions by adding new pods with the topologySpreadConstraints to ensure distribution across nodes.
  - name: daemonset
    # deployments[0].annotations -- Default Deployment - Annotations to add to the deployment
    annotations: {}
    # deployments[0].podAnnotations -- Default Deployment - Annotations to add to the pods
    podAnnotations: {}
    # deployments[0].replicaCount -- Default Deployment - Number of replicas
    replicaCount: 1
    # deployments[0].nodeSelector -- Default Deployment - Node labels for pod assignment
    nodeSelector: {}
    resources:
      limits:
        # deployments[0].resources.limits.daemonset -- Default Deployment - daemonset limit for the overprovision pods
        cpu: ${ daemonset_overprovision }
        # deployments[0].resources.limits.memory -- Default Deployment - Memory limit for the overprovision pods
        memory: "10Mi"
      requests:
        # deployments[0].resources.requests.daemonset -- Default Deployment - CPU requested for the overprovision pods
        cpu: ${ daemonset_overprovision }
        # deployments[0].resources.requests.memory -- Default Deployment - Memory requested for the overprovision pods
        memory: "10Mi"
    # deployments[0].tolerations -- Default Deployment - Optional deployment tolerations
    tolerations: []
    # deployments[0].affinity -- Default Deployment - Map of node/pod affinities
    affinity: {}
    # deployments[0].labels -- Default Deployment - Optional labels tolerations
    labels: {}
    # deployments[0].topologySpreadConstraints -- Default Deployment - Optional topology spread constraints
    topologySpreadConstraints:
      - maxSkew: 1
        topologyKey: kubernetes.io/hostname
        whenUnsatisfiable: ScheduleAnyway
        nodeTaintsPolicy: Honor

serviceAccount:
  # serviceAccount.create -- Determine whether a Service Account should be created or it should reuse an exiting one
  create: true
  # serviceAccount.name -- The name of the ServiceAccount to use. If not set and create is `true`, a name is generated using the fullname template
  name:
  # serviceAccount.annotations -- Additional Service Account annotations
  annotations: {}
  # serviceAccount.automountServiceAccountToken -- Automount API credentials for a Service Account
  automountServiceAccountToken: true
