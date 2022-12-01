{{/* Common HumanSignals definitions */}}

{{- define "humansignals.humansignalsSecretKey.existingSecret" }}
  {{- if .Values.humansignalsSecretKey.existingSecret -}}
    {{- .Values.humansignalsSecretKey.existingSecret -}}
  {{- else -}}
    {{- template "humansignals.fullname" . -}}
  {{- end -}}
{{- end }}

{{- define "snippet.humansignals-env" }}
- name: SECRET_KEY
  valueFrom:
    secretKeyRef:
      name: {{ template "humansignals.humansignalsSecretKey.existingSecret" . }}
      key: {{ .Values.humansignalsSecretKey.existingSecretKey }}
- name: SITE_URL
  value: {{ template "humansignals.site.url" . }}
- name: DEPLOYMENT
  value: {{ template "humansignals.deploymentEnv" . }}
- name: CAPTURE_INTERNAL_METRICS
  value: {{ .Values.web.internalMetrics.capture | quote }}
- name: HELM_INSTALL_INFO
  value: {{ template "humansignals.helmInstallInfo" . }}
- name: LOGGING_FORMATTER_NAME
  value: json
{{- end }}

{{- define "snippet.humansignals-sentry-env" }}
- name: SENTRY_DSN
  value: {{ .Values.sentryDSN | quote }}
{{- end }}
