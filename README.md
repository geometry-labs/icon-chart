# icon-node

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

A Helm chart for ICON blockchain node

## Values


| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cloudProvider | string | `"aws"` |  |
| deployment.replicas | int | `1` |  |
| deployment.resources | object | `{}` |  |
| deployment.storage.accessModes[0] | string | `"ReadWriteOnce"` |  |
| deployment.storage.dataSize | string | `"360Gi"` |  |
| deployment.storage.storageClassName | string | `"ebs-sc"` |  |
| image.repo | string | `"iconloop/prep-node"` |  |
| image.tag | string | `"20210314.0"` |  |
| namespace | string | `"icon"` |  |
| node.amqpKey | string | `""` |  |
| node.amqpTarget | string | `"127.0.0.1"` |  |
| node.certificate.autoGenerate | bool | `true` |  |
| node.certificate.contents | string | `"-----BEGIN EC PRIVATE KEY-----\n... your key contents ...\n-----END EC PRIVATE KEY-----"` |  |
| node.certificate.password | string | `"password123"` |  |
| node.endpointURL | string | `""` |  |
| node.fastestStart | string | `"\"yes\""` |  |
| node.findNeighbor | bool | `true` |  |
| node.findNeighborCount | int | `5` |  |
| node.findNeighborOption | string | `""` |  |
| node.healthCheckInterval | int | `30` |  |
| node.iconLogLevel | string | `"DEBUG"` |  |
| node.loopchainLogLevel | string | `"DEBUG"` |  |
| node.networkEnvironment | string | `"mainnet"` |  |
| node.ports.gRPC | int | `7100` |  |
| node.ports.rpc | int | `9000` |  |
| node.purpose | string | `"prep"` |  |
| node.runLocal | bool | `false` |  |
| node.slackPrefix | string | `""` |  |
| node.slackURL | string | `""` |  |
| node.useExternalMQ | bool | `false` |  |
| node.useNAT | string | `"no"` |  |
| node.useSlack | string | `"no"` |  |

