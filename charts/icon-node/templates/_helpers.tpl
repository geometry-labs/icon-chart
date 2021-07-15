{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fullname" -}}
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
{{- define "chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "labels" -}}
helm.sh/chart: {{ include "chart" . }}
{{ include "selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "selectorLabels" -}}
app.kubernetes.io/name: {{ include "name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* Returns the PSP name */}}
{{- define "podSecurityPolicyName" -}}
{{ template "fullname" . }}
{{- end }}

{{/* Returns the statefulset name */}}
{{- define "statefulsetName" -}}
{{ .Release.Name }}
{{- end }}

{{/* Returns the certificate secret name */}}
{{- define "certificate-name" -}}
{{ .Release.Name }}-node-certificate
{{- end }}

{{/* Returns the certificate secret name */}}
{{- define "certificate-password" -}}
{{ .Release.Name }}-certificate-password
{{- end }}

{{/* Returns the gRPC service name */}}
{{- define "gRPCService" -}}
{{ .Release.Name }}-grpc
{{- end }}

{{/* Returns the JSON-RPC service name */}}
{{- define "rpcService" -}}
{{ .Release.Name }}-rpc
{{- end }}

{{/* Returns the data PVC name */}}
{{- define "dataPVCName" -}}
{{ .Release.Name }}-data
{{- end }}