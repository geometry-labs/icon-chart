{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "icon-node.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "icon-node.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "icon-node.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "icon-node.labels" -}}
helm.sh/chart: {{ include "icon-node.chart" . }}
{{ include "icon-node.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "icon-node.selectorLabels" -}}
app.kubernetes.io/name: {{ include "icon-node.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/* Returns the PSP name */}}
{{- define "icon-node.podSecurityPolicyName" -}}
{{ .Release.Name }}
{{- end }}

{{/* Returns the statefulset name */}}
{{- define "icon-node.statefulsetName" -}}
{{ .Release.Name }}
{{- end }}

{{/* Returns the certificate secret name */}}
{{- define "icon-node.certificate-name" -}}
{{ .Release.Name }}-node-certificate
{{- end }}

{{/* Returns the certificate secret name */}}
{{- define "icon-node.certificate-password" -}}
{{ .Release.Name }}-certificate-password
{{- end }}

{{/* Returns the gRPC service name */}}
{{- define "icon-node.gRPCService" -}}
{{ .Release.Name }}-grpc
{{- end }}

{{/* Returns the JSON-RPC service name */}}
{{- define "icon-node.rpcService" -}}
{{ .Release.Name }}-rpc
{{- end }}