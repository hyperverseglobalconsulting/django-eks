storageClasses:
  - name: gp3-sc
    annotations:
      storageclass.kubernetes.io/is-default-class: "true"
    volumeBindingMode: WaitForFirstConsumer
    reclaimPolicy: Delete
    allowVolumeExpansion: true
    parameters:
      type: gp3
      encrypted: "true"
      fsType: ext4

controller:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: eks.amazonaws.com/nodegroup
            operator: In
            values:
            - ${nodegroup}

defaultStorageClass:
  enabled: true
