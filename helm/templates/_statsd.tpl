{{/* Common statsd ENV variables and helpers used by humansignals */}}

{{/* Return the statsd service host */}}
{{- define "humansignals.statsd.host" -}}
{{- if (index .Values "prometheus-statsd-exporter" "enabled") }}
  {{- printf "%s-prometheus-statsd-exporter" (include "humansignals.fullname" .) -}}
{{- else if .Values.externalStatsd.host }}
  {{- printf "%s" .Values.externalStatsd.host -}}
{{- end -}}
{{- end -}}

{{/* Return the statsd service port */}}
{{- define "humansignals.statsd.port" -}}
{{- if (index .Values "prometheus-statsd-exporter" "enabled") }}
  {{- index .Values "prometheus-statsd-exporter" "statsd" "tcpPort" }}
{{- else if .Values.externalStatsd.port }}
  {{- printf "%s" .Values.externalStatsd.port -}}
{{- end -}}
{{- end -}}

{{/* ENV used by humansignals deployments for configuring statsd */}}
{{- define "snippet.statsd-env" }}
{{- if or (index .Values "prometheus-statsd-exporter" "enabled") (and (.Values.externalStatsd.host) (.Values.externalStatsd.port)) }}
- name: STATSD_HOST
  value: "{{ include "humansignals.statsd.host" . }}"
- name: STATSD_PORT
  value: "{{ include "humansignals.statsd.port" . }}"
{{- end }}
{{- end }}
