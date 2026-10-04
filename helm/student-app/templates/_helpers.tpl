{{/*
Application name
*/}}

{{- define "student-app.name" -}}

{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}

{{- end }}


{{/*
Fully qualified application name
*/}}

{{- define "student-app.fullname" -}}

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
Chart label
*/}}

{{- define "student-app.chart" -}}

{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}

{{- end }}


{{/*
Common labels
*/}}

{{- define "student-app.labels" -}}

helm.sh/chart: {{ include "student-app.chart" . }}

{{ include "student-app.selectorLabels" . }}

app.kubernetes.io/managed-by: {{ .Release.Service }}

app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}

{{- end }}


{{/*
Selector labels
*/}}

{{- define "student-app.selectorLabels" -}}

app.kubernetes.io/name: {{ include "student-app.name" . }}

app.kubernetes.io/instance: {{ .Release.Name }}

{{- end }}


{{/*
Service account name
*/}}

{{- define "student-app.serviceAccountName" -}}

{{- if .Values.serviceAccount.create }}

{{- default (include "student-app.fullname" .) .Values.serviceAccount.name }}

{{- else }}

{{- default "default" .Values.serviceAccount.name }}

{{- end }}

{{- end }}