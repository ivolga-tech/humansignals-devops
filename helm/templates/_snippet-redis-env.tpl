{{/* Common Redis ENV variables */}}
{{- define "snippet.redis-env" }}

- name: POSTHOG_REDIS_HOST
  value: {{ include "humansignals.redis.host" . }}

- name: POSTHOG_REDIS_PORT
  value: {{ include "humansignals.redis.port" . }}

{{- if (include "humansignals.redis.auth.enabled" .) }}
- name: POSTHOG_REDIS_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "humansignals.redis.secretName" . }}
      key: {{ include "humansignals.redis.secretPasswordKey" . }}
{{- end }}

{{- end }}
