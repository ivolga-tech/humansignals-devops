{{/* Common PgBouncer helpers used by humansignals */}}

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
    {{- default (printf "%s-pgbouncer" (include "humansignals.fullname" .)) .Values.pgbouncer.fqdn -}}
{{- end -}}

{{/*
Set PgBouncer port
*/}}
{{- define "humansignals.pgbouncer.port" -}}
    6543
{{- end -}}

{{/*
Set Read PgBouncer host
*/}}
{{- define "humansignals.pgbouncer-read.host" -}}
    {{- default (printf "%s-pgbouncer-read" (include "humansignals.fullname" .)) .Values.pgbouncerRead.fqdn -}}
{{- end -}}

{{/*
Set PgBouncer port
*/}}
{{- define "humansignals.pgbouncer-read.port" -}}
    6543
{{- end -}}
