{{/*
Expand the name of the chart.
*/}}
{{- define "inventory-database.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "inventory-database.fullname" -}}
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
{{- define "inventory-database.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "inventory-database.labels" -}}
helm.sh/chart: {{ include "inventory-database.chart" . }}
app: postgresql-persistent
app.kubernetes.io/component: postgresql-persistent
app.kubernetes.io/instance: postgresql-persistent
app.kubernetes.io/part-of: inventory
app.openshift.io/runtime: postgresql
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "inventory-database.selectorLabels" -}}
app.kubernetes.io/name: {{ include "inventory-database.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Storage labels
*/}}
{{- define "inventory-database.appLabels" -}}
app: postgresql-persistent
app.kubernetes.io/component: postgresql-persistent
app.kubernetes.io/instance: postgresql-persistent
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "inventory-database.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "inventory-database.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
