{{/* Common Kafka ENV variables and helpers used by humansignals */}}

{{/* Return the Kafka fullname */}}
{{- define "humansignals.kafka.fullname" }}
{{- if .Values.kafka.fullnameOverride }}
{{- .Values.kafka.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else if .Values.kafka.nameOverride }}
{{- printf "%s-%s" .Release.Name .Values.kafka.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else -}}
{{- printf "%s-%s" (include "humansignals.fullname" .) "kafka" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/* Return the Kafka hosts (brokers) as a comma separated list */}}
{{- define "humansignals.kafka.brokers"}}
{{- if .Values.kafka.enabled -}}
{{- printf "%s:%d" (include "humansignals.kafka.fullname" .) (.Values.kafka.service.port | int) }}
{{- else -}}
{{ join "," .Values.externalKafka.brokers | quote }}
{{- end }}
{{- end }}

{{/* Return the Kafka hosts (brokers) as a comma separated list */}}
{{- define "humansignals.sessionRecordingKafka.brokers"}}
{{- if .Values.kafka.enabled -}}
{{- printf "%s:%d" (include "humansignals.kafka.fullname" .) (.Values.kafka.service.port | int) }}
{{- else -}}
{{ join "," .Values.externalSessionRecordingKafka.brokers | quote }}
{{- end }}
{{- end }}

{{/* ENV used by humansignals deployments for connecting to Kafka */}}
{{- define "snippet.kafka-env" }}
{{- $hostsWithPrefix := list }}
{{- range $host := .Values.externalKafka.brokers }}
{{- $hostWithPrefix := (printf "kafka://%s" $host) }}
{{- $hostsWithPrefix = append $hostsWithPrefix $hostWithPrefix }}
{{- end }}

# NOTE: This is deprecated and KAFKA_HOSTS should be used instead but whilst the chart is still available we need to keep this for backwards compatibility
- name: KAFKA_URL
{{- if .Values.kafka.enabled }}
  value: {{ printf "kafka://%s" ( include "humansignals.kafka.brokers" . ) }}
{{ else }}
  value: {{ join "," $hostsWithPrefix | quote }}
{{- end }}

# Used by humansignals/plugin-server. Expected format: comma-separated list of "host:port"
- name: KAFKA_HOSTS
  value: {{ ( include "humansignals.kafka.brokers" . ) }}

# Used by humansignals/plugin-server when running a recordings workload. Expected format: comma-separated list of "host:port"
- name: SESSION_RECORDING_KAFKA_HOSTS
  value: {{ ( include "humansignals.sessionRecordingKafka.brokers" . ) }}

{{- if and (not .Values.kafka.enabled) .Values.externalKafka.tls }}
- name: KAFKA_SECURITY_PROTOCOL
  value: SSL
{{- end }}

{{- if and (not .Values.kafka.enabled) .Values.externalSessionRecordingKafka.tls }}
- name: SESSION_RECORDING_KAFKA_SECURITY_PROTOCOL
  value: SSL
{{- end }}
{{- end }}