{{- define "statuspage.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "statuspage.fullname" -}}
{{- printf "%s-%s" .Release.Name (include "statuspage.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end }}
{{- define "status-page.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "status-page.fullname" -}}
{{- printf "%s-%s" .Release.Name (include "status-page.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end }}
{{- define "status-page.labels" -}}
app.kubernetes.io/name: {{ include "status-page.name" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}