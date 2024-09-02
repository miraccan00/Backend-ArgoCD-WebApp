{{/*
Expand the name of the chart.
*/}}
{{- define "djangoapp.name" -}}
{{- default .Values.nameOverride .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "djangoapp.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else }}
{{- $name := default .Values.nameOverride .Chart.Name }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "djangoapp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "djangoapp.labels" -}}
helm.sh/chart: {{ include "djangoapp.chart" . }}
{{ include "djangoapp.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "djangoapp.selectorLabels" -}}
app.kubernetes.io/name: {{ include "djangoapp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "djangoapp.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "djangoapp.fullname" .) .Values.serviceAccount.name -}}
{{- else }}
{{- default "default" .Values.serviceAccount.name -}}
{{- end }}
{{- end }}

{{/*
Return the namespace to deploy to.
*/}}
{{- define "djangoapp.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride -}}
{{- end }}

{{/*
Resource definitions for various resources.
*/}}
{{- define "djangoapp.resources" -}}
{{- toYaml .Values.resources | nindent 2 -}}
{{- end }}

{{/*
Affinity settings for the application pods.
*/}}
{{- define "djangoapp.affinity" -}}
{{- toYaml .Values.affinity | nindent 2 -}}
{{- end }}

{{/*
Tolerations settings for the application pods.
*/}}
{{- define "djangoapp.tolerations" -}}
{{- toYaml .Values.tolerations | nindent 2 -}}
{{- end }}

{{/*
Node selector settings for the application pods.
*/}}
{{- define "djangoapp.nodeSelector" -}}
{{- toYaml .Values.nodeSelector | nindent 2 -}}
{{- end }}

{{/*
Pod annotations
*/}}
{{- define "djangoapp.podAnnotations" -}}
{{- toYaml .Values.podAnnotations | nindent 4 -}}
{{- end }}
