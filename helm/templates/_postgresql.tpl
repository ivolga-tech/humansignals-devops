{{/* Common PostgreSQL ENV variables and helpers used by HumanSignals */}}

{{/* ENV used by humansignals deployments for connecting to postgresql */}}
{{- define "snippet.postgresql-env" }}
- name: POSTHOG_POSTGRES_HOST
  value: {{ template "humansignals.pgbouncer.host" . }}
- name: POSTHOG_POSTGRES_PORT
  value: {{ include "humansignals.pgbouncer.port" . | quote }}
- name: POSTHOG_DB_USER
  value: {{ include "humansignals.postgresql.username" . }}
- name: POSTHOG_DB_NAME
  value: {{ include "humansignals.postgresql.database" . }}
- name: POSTHOG_DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "humansignals.postgresql.secretName" . }}
      key: {{ include "humansignals.postgresql.secretPasswordKey" . }}
- name: USING_PGBOUNCER
  value: 'true'
{{ if .Values.pgbouncerRead.enabled -}}
- name: POSTHOG_POSTGRES_READ_HOST
  value: {{ template "humansignals.pgbouncer-read.host" . }}
{{ end -}}
{{- end }}

{{/* ENV used by migrate job for connecting to postgresql */}}
{{- define "snippet.postgresql-migrate-env" }}
# Connect directly to postgres (without pgbouncer) to avoid statement_timeout for longer-running queries
- name: POSTHOG_POSTGRES_HOST
  value: {{ template "humansignals.postgresql.host" . }}
- name: POSTHOG_POSTGRES_PORT
  value: {{ include "humansignals.postgresql.port" . | quote }}
- name: POSTHOG_DB_USER
  value: {{ include "humansignals.postgresql.username" . }}
- name: POSTHOG_DB_NAME
  value: {{ include "humansignals.postgresql.database" . }}
- name: POSTHOG_DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "humansignals.postgresql.secretName" . }}
      key: {{ include "humansignals.postgresql.secretPasswordKey" . }}
- name: USING_PGBOUNCER
  value: 'false'
{{- end }}

{{/*
Create a default fully qualified postgresql app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "humansignals.postgresql.fullname" -}}
{{- if .Values.postgresql.fullnameOverride -}}
{{- .Values.postgresql.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else if .Values.postgresql.nameOverride -}}
{{- printf "%s-%s" .Release.Name .Values.postgresql.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" (include "humansignals.fullname" .) "postgresql" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Set postgres secret
*/}}
{{- define "humansignals.postgresql.secretName" -}}
{{- if and .Values.postgresql.enabled .Values.postgresql.existingSecret }}
{{- .Values.postgresql.existingSecret | quote -}}
{{- else if and (not .Values.postgresql.enabled) .Values.externalPostgresql.existingSecret }}
{{- .Values.externalPostgresql.existingSecret | quote -}}
{{- else -}}
{{- if .Values.postgresql.enabled -}}
{{- template "humansignals.postgresql.fullname" . -}}
{{- else -}}
{{- printf "%s-external" (include "humansignals.fullname" .) -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Set postgres secret password key
*/}}
{{- define "humansignals.postgresql.secretPasswordKey" -}}
{{- if and (not .Values.postgresql.enabled) .Values.externalPostgresql.existingSecretPasswordKey }}
{{- .Values.externalPostgresql.existingSecretPasswordKey | quote -}}
{{- else -}}
"postgresql-password"
{{- end -}}
{{- end -}}

{{/*
Set postgres FQDN
*/}}
{{- define "humansignals.postgresql.fqdn" -}}
{{- $fullname := include "humansignals.postgresql.fullname" . -}}
{{- $releaseNamespace := .Release.Namespace -}}
{{- $clusterDomain := .Values.clusterDomain -}}
{{- printf "%s.%s.svc.%s." $fullname $releaseNamespace $clusterDomain -}}
{{- end -}}

{{/*
Set postgres host
*/}}
{{- define "humansignals.postgresql.host" -}}
{{- if .Values.postgresql.enabled -}}
{{- template "humansignals.postgresql.fullname" . -}}
{{- else -}}
{{- required "externalPostgresql.postgresqlHost is required if not postgresql.enabled" .Values.externalPostgresql.postgresqlHost | quote }}
{{- end -}}
{{- end -}}

{{/*
Set postgres port
*/}}
{{- define "humansignals.postgresql.port" -}}
{{- if .Values.postgresql.enabled -}}
5432
{{- else -}}
{{- .Values.externalPostgresql.postgresqlPort -}}
{{- end -}}
{{- end -}}

{{/*
Set postgres username
*/}}
{{- define "humansignals.postgresql.username" -}}
{{- if .Values.postgresql.enabled -}}
"postgres"
{{- else -}}
{{- .Values.externalPostgresql.postgresqlUsername | quote -}}
{{- end -}}
{{- end -}}

{{/*
Set postgres database
*/}}
{{- define "humansignals.postgresql.database" -}}
{{- if .Values.postgresql.enabled -}}
{{- .Values.postgresql.postgresqlDatabase | quote -}}
{{- else -}}
{{- .Values.externalPostgresql.postgresqlDatabase | quote -}}
{{- end -}}
{{- end -}}

{{/*
Set if postgres secret should be created
*/}}
{{- define "humansignals.postgresql.createSecret" -}}
{{- if and (not .Values.postgresql.enabled) .Values.externalPostgresql.postgresqlPassword -}}
{{- true -}}
{{- end -}}
{{- end -}}
