auth:
  postgresPassword: "${postgresql_password}"
  username: "${username}"
  database: "${database}"
  password: "${postgresql_password}"

primary:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: "eks.amazonaws.com/nodegroup"
            operator: In
            values:
            - ${nodegroup}
  persistence:
    enabled: true
    size: 8Gi
    storageClass: gp3-sc
