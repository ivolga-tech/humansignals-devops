{{/* Common PgBouncer helpers used by HumanSignals */}}

{{/*
Set PgBouncer FQDN
*/}}
{{- define "humansignals.pgbouncer.fqdn" -}}
    {{- $fullname := include "humansignals.fullname" . -}}
    {{- $serviceName := printf "%s-pgbouncer" $fullname -}}
    {{- $releaseNamespace := .Release.Namespace -}}
    {{- $clusterDomain := .Values.clusterDomain -}}
    {{- printf "%s.%s.svc.%s." $serviceName $releaseNamespace $clusterDomain -}}
{{- end -}}

{{/*
Set PgBouncer host
*/}}
{{- define "humansignals.pgbouncer.host" -}}
    {{- template "humansignals.fullname" . }}-pgbouncer
{{- end -}}

{{/*
Set PgBouncer port
*/}}
{{- define "humansignals.pgbouncer.port" -}}
    6543
{{- end -}}
