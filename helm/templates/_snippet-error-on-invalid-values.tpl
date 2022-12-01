{{/* Checks whether invalid values are set */}}
{{- define "snippet.error-on-invalid-values" }}
  {{- if and .Values.postgresql.enabled .Values.externalPostgresql.postgresqlHost }}
    {{- required (printf (include "snippet.error-on-invalid-values-template" .)
      "externalPostgresql.postgresqlHost cannot be set if postgresql.enabled is true" ""
    ) nil -}}

  {{- else if and .Values.redis.enabled .Values.externalRedis.host }}
    {{- required (printf (include "snippet.error-on-invalid-values-template" .)
      "externalRedis.host cannot be set if redis.enabled is true" ""
    ) nil -}}

  {{- else if and .Values.kafka.enabled .Values.externalKafka.brokers }}
    {{- required (printf (include "snippet.error-on-invalid-values-template" .)
      "externalKafka.brokers cannot be set if kafka.enabled is true" ""
    ) nil -}}

  {{- else if and .Values.clickhouse.enabled .Values.externalClickhouse.host }}
    {{- required (printf (include "snippet.error-on-invalid-values-template" .)
      "externalClickhouse.host cannot be set if clickhouse.enabled is true" ""
    ) nil -}}

  {{- else if and .Values.clickhouse.enabled .Values.externalClickhouse.cluster }}
    {{- required (printf (include "snippet.error-on-invalid-values-template" .)
      "externalClickhouse.cluster cannot be set if clickhouse.enabled is true" ""
    ) nil -}}

  {{- else if .Values.certManager }}
    {{- required (printf (include "snippet.error-on-invalid-values-template" .)
      "certManager value has been renamed to cert-manager"
    ) nil -}}

  {{- else if .Values.beat }}
    {{- required (printf (include "snippet.error-on-invalid-values-template" .)
      "beat deployment has been removed"
    ) nil -}}

  {{- else if .Values.clickhouseOperator }}
    {{- required (printf (include "snippet.error-on-invalid-values-template" .)
      "clickhouseOperator values are no longer valid"
    ) nil -}}

  {{- else if or .Values.redis.port .Values.redis.host .Values.redis.password }}
    {{- required (printf (include "snippet.error-on-invalid-values-template" .)
      "redis.port, redis.host and redis.password are no longer valid"
    ) nil -}}

  {{- else if .Values.clickhouse.host }}
    {{- required (printf (include "snippet.error-on-invalid-values-template" .)
      "clickhouse.host has been moved to externalClickhouse.host"
    ) nil -}}

  {{- else if .Values.clickhouse.replication }}
    {{- required (printf (include "snippet.error-on-invalid-values-template" .)
      "clickhouse.replication has been removed"
    ) nil -}}

  {{- else if .Values.postgresql.postgresqlHost }}
    {{- required (printf (include "snippet.error-on-invalid-values-template" .)
      "postgresql.postgresqlHost has been moved to externalPostgresql.postgresqlHost"
    ) nil -}}

  {{- else if .Values.postgresql.postgresqlPort }}
    {{- required (printf (include "snippet.error-on-invalid-values-template" .)
      "postgresql.postgresqlPort has been moved to externalPostgresql.postgresqlPort"
    ) nil -}}

  {{- else if .Values.postgresql.postgresqlUsername }}
    {{- if ne .Values.postgresql.postgresqlUsername "postgres" }}
      {{- required (printf (include "snippet.error-on-invalid-values-template" .)
        "postgresql.postgresqlUsername has been removed"
      ) nil -}}
    {{- end -}}

    {{- if .Values.clickhouse.useNodeSelector }}
      {{- required (printf (include "snippet.error-on-invalid-values-template" .)
        "clickhouse.useNodeSelector has been removed"
        "please use the clickhouse.nodeSelector variable instead"
      ) nil -}}
    {{- end -}}

    {{- if and .Values.pluginsAsync.enabled (not .Values.plugins.enabled) }}
      {{- required (printf (include "snippet.error-on-invalid-values-template" .)
        "pluginsAsync.enabled cannot be set if plugins.enabled is false" ""
      ) nil -}}
    {{- end -}}

    {{- if and (or .Values.pluginsAsync.enabled .Values.plugins.enabled) (or
    .Values.pluginsIngestion.enabled .Values.pluginsExports.enabled
    .Values.pluginsJobs.enabled .Values.pluginsScheduler.enabled) }}
      {{- required (printf (include "snippet.error-on-invalid-values-template" .)
        "plugins*.enabled cannot be set if plugins.enabled or pluginsAsync.enabled is true" ""
      ) nil -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "snippet.error-on-invalid-values-template" }}

==== INVALID VALUES ====

Read more on how to update your values.yaml:

- %s
  %s

=========================
{{ end -}}
