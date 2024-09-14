autoDiscovery:
  clusterName: ${cluster_name}

awsRegion: ${aws_region}

# Uncomment and replace the placeholder with the actual value if needed
# rbac:
#   serviceAccount:
#     annotations:
#       eks.amazonaws.com/role-arn: role_arn

cloudProvider: aws

extraArgs:
  logtostderr: "true"
  stderrthreshold: "info"
  v: "4"
  cloud-provider: "aws"
  leader-elect: "false"
  skip-nodes-with-local-storage: "false"
  expander: "least-waste"
  node-group-auto-discovery: "asg:tag=k8s.io/cluster-autoscaler/enabled,k8s.io/cluster-autoscaler/${cluster_name}"
  scale-down-enabled: "true"
  balance-similar-node-groups: "true"
  scale-down-utilization-threshold: 0.5
  scale-down-delay-after-add: "10m"
  scale-down-unneeded-time: "10m"
  scale-down-delay-after-delete: "1m"
  scale-down-delay-after-failure: "3m"
  skip-nodes-with-system-pods: "false"

image:
  repository: k8s.gcr.io/autoscaling/cluster-autoscaler
  tag: v1.26.2

affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: eks.amazonaws.com/nodegroup
          operator: In
          values:
          - ${nodegroup}
