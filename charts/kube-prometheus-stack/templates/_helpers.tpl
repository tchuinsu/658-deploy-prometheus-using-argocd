{{/*
Expand the name of the chart.
*/}}
{{- define "kube-prometheus-stack.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "kube-prometheus-stack.fullname" -}}
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
Create chart label.
*/}}
{{- define "kube-prometheus-stack.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels applied to every resource in this chart.
*/}}
{{- define "kube-prometheus-stack.labels" -}}
helm.sh/chart: {{ include "kube-prometheus-stack.chart" . }}
{{ include "kube-prometheus-stack.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
environment: {{ .Values.environment | default "stage" }}
{{- end }}

{{/*
Selector labels.
*/}}
{{- define "kube-prometheus-stack.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kube-prometheus-stack.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Namespace helper — falls back to Release.Namespace.
*/}}
{{- define "kube-prometheus-stack.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride }}
{{- end }}
