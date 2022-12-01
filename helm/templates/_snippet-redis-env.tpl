{{/* Common Redis ENV variables */}}
{{- define "snippet.redis-env" }}

- name: HUMANSIGNALS_REDIS_HOST
  value: {{ include "humansignals.redis.host" . }}

- name: HUMANSIGNALS_REDIS_PORT
  value: {{ include "humansignals.redis.port" . }}

{{- if (include "humansignals.redis.auth.enabled" .) }}
- name: HUMANSIGNALS_REDIS_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "humansignals.redis.secretName" . }}
      key: {{ include "humansignals.redis.secretPasswordKey" . }}
{{- end }}

{{- end }}
