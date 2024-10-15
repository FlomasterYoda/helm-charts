{{- define "common.labels" -}}
{{- with . -}}
{{ toYaml . }}
{{- end }}
{{- end -}}

{{- define "common.secretEnvVars" -}}
{{- range $secret := .Secrets }}
{{- range $index := until (len $secret.KUBE_SECRET_PROPERTY | int) -}}
- name: {{ index $secret.KUBE_SECRET_PROPERTY $index }}
  valueFrom:
    secretKeyRef:
      name: {{ $secret.KUBE_SECRET_NAME }}
      key: {{ index $secret.AWS_SECRET_PROPERTY $index }}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "common.envVars" -}}
{{- range $key, $value := .Env -}}
- name: {{ $key }}
  value: {{ $value }}
{{- end }}
{{- end -}}

{{- define "common.envVarValuesFrom" -}}
{{- with .envVarValuesFrom -}}
{{- toYaml . }}
{{- end -}}
{{- end -}}

{{- define "common.envVarsFrom" -}}
{{- with .EnvFrom -}}
envFrom:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}

{{- define "common.annotations" -}}
  {{- with . -}}
    {{ toYaml . }}
  {{- end }}
{{- end -}}
