# icon-node

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

A Helm chart for ICON blockchain node

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cloudProvider | string | `"aws"` |  |
| deployment.annotations | string | `nil` |  |
| deployment.nodeName | string | `nil` |  |
| deployment.nodeSelector | string | `nil` |  |
| deployment.replicas | int | `1` |  |
| deployment.resources | object | `{}` |  |
| deployment.storage.accessModes[0] | string | `"ReadWriteOnce"` |  |
| deployment.storage.dataSize | string | `"480Gi"` |  |
| deployment.storage.selectorLabels | object | `{}` |  |
| deployment.storage.storageClassName | string | `"ebs-sc"` |  |
| deployment.tolerations | list | `[]` |  |
| image.repo | string | `"iconloop/icon2-node"` |  |
| image.tag | string | `"latest"` |  |
| namespace | string | `"icon"` |  |
| node.checkBlockStack | int | `10` |  |
| node.checkInterval | int | `10` |  |
| node.checkPeerStack | int | `6` |  |
| node.checkStackLimit | int | `360` |  |
| node.checkTimeout | int | `10` |  |
| node.fastestStart | bool | `true` |  |
| node.goloopLogLevel | string | `"debug"` |  |
| node.isAutogenCert | bool | `true` |  |
| node.isTailWorker | bool | `true` |  |
| node.logOutputType | string | `"file"` |  |
| node.ntpRefreshTime | int | `360` |  |
| node.ntpServer | string | `""` |  |
| node.ports.p2p | int | `7100` |  |
| node.ports.rpc | int | `9000` |  |
| node.role | int | `0` |  |
| node.service | string | `"MainNet"` |  |
| service.p2p.type | string | `"NodePort"` |  |
| service.rpc.type | string | `"NodePort"` |  |


## Using instance storage

Minimal values required to use instance storage:

```yaml
deployment:
  replicas: 3
  tolerations:
    - effect: NoSchedule
      key: bxnode
  storage:
    storageClassName: instance-nvme
    selectorLabels:
      volume-type: ssd
    dataSize: 869Gi
  nodeSelector:
    "geometry.io/node-purpose": "bxnode"
```

Once you have deployed the chart, you must provision enough instances for your replicas.
Ensure they're deployed in different availability zones.

To enable scheduling, you must manually bind the claim to the PV by editing each PV manifest and adding:

```yaml
spec:
  claimRef:
    name: name-of-pvc-0
    namespace: namespace-of-pvc
```

Once you have edited each PV, the claims should attach and the pods should schedule.
Ensure a 1:1 mapping between replicas and PVs or you will not be able to schedule all of the pods.