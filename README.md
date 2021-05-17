# icon-node

![](https://github.com/geometry-labs/icon-chart/actions/workflows/release.yaml/badge.svg)
![](https://github.com/geometry-labs/icon-chart/actions/workflows/test.yaml/badge.svg)

Helm chart for running nodes for the ICON Blockchain.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| certificateContents | string | `"-----BEGIN EC PRIVATE KEY-----\n... your key contents ...\n-----END EC PRIVATE KEY-----"` |  |
| certificatePassword | string | `"password123"` |  |
| fastestStart | string | `"\"yes\""` |  |
| gRPCPort | int | `7100` |  |
| generateCert | bool | `true` |  |
| iconLogLevel | string | `"DEBUG"` |  |
| image.repo | string | `"iconloop/prep-node"` |  |
| image.tag | string | `"2009031457xdaf395"` |  |
| local | bool | `false` |  |
| loopchainLogLevel | string | `"DEBUG"` |  |
| namespace | string | `"icon"` |  |
| networkEnvironment | string | `"mainnet"` |  |
| node_purpose | string | `"prep"` |  |
| resources | object | `{}` |  |
| rpcPort | int | `9000` |  |
| storage.accessModes[0] | string | `"ReadWriteOnce"` |  |
| storage.dataSize | string | `"360Gi"` |  |

