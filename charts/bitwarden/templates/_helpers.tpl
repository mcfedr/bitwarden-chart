{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "bitwarden.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bitwarden.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "bitwarden.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "bitwarden.global" -}}
- name: globalSettings__selfHosted
  value: "true"
- name: globalSettings__pushRelayBaseUri
  value: "https://push.bitwarden.com"
- name: globalSettings__installation__identityUri
  value: "https://identity.bitwarden.com"
- name: globalSettings__baseServiceUri__vault
  value: https://{{ .Values.global.host }}
- name: globalSettings__baseServiceUri__api
  value: https://{{ .Values.global.host }}/api
- name: globalSettings__baseServiceUri__identity
  value: https://{{ .Values.global.host }}/identity
- name: globalSettings__baseServiceUri__admin
  value: https://{{ .Values.global.host }}/admin
- name: globalSettings__baseServiceUri__notifications
  value: https://{{ .Values.global.host }}/notifications
- name: globalSettings__attachment__baseDirectory
  value: /etc/bitwarden/core/attachments
- name: globalSettings__attachment__baseUrl
  value: https://{{ .Values.global.host }}/attachments
- name: globalSettings__dataProtection__directory
  value: /etc/bitwarden/core/aspnet-dataprotection
- name: globalSettings__logDirectory
  value: /etc/bitwarden/core/logs
- name: globalSettings__licenseDirectory
  value: /etc/bitwarden/core/licenses
- name: globalSettings__identityServer__certificatePassword
  valueFrom:
    secretKeyRef:
      name: {{ include "bitwarden.fullname" . }}-identity
      key: certificate-password
- name: globalSettings__sqlServer__connectionString
  valueFrom:
    secretKeyRef:
      name: {{ include "bitwarden.fullname" . }}-mssql
      key: connection-string
- name: globalSettings__internalIdentityKey
  valueFrom:
    secretKeyRef:
      name: {{ include "bitwarden.fullname" . }}-global
      key: internal-identity-key
- name: globalSettings__duo__aKey
  valueFrom:
    secretKeyRef:
      name: {{ include "bitwarden.fullname" . }}-global
      key: duo-key
- name: globalSettings__installation__id
  valueFrom:
    secretKeyRef:
      name: {{ include "bitwarden.fullname" . }}-global
      key: installation-id
- name: globalSettings__installation__key
  valueFrom:
    secretKeyRef:
      name: {{ include "bitwarden.fullname" . }}-global
      key: installation-key
- name: globalSettings__yubico__clientId
  valueFrom:
    secretKeyRef:
      name: {{ include "bitwarden.fullname" . }}-global
      key: yubico-client-id
- name: globalSettings__yubico__key
  valueFrom:
    secretKeyRef:
      name: {{ include "bitwarden.fullname" . }}-global
      key: yubico-key
- name: globalSettings__mail__replyToEmail
  valueFrom:
    secretKeyRef:
      name: {{ include "bitwarden.fullname" . }}-global
      key: mail-reply-to-email
- name: globalSettings__mail__smtp__host
  valueFrom:
    secretKeyRef:
      name: {{ include "bitwarden.fullname" . }}-global
      key: mail-host
- name: globalSettings__mail__smtp__username
  valueFrom:
    secretKeyRef:
      name: {{ include "bitwarden.fullname" . }}-global
      key: mail-username
- name: globalSettings__mail__smtp__password
  valueFrom:
    secretKeyRef:
      name: {{ include "bitwarden.fullname" . }}-global
      key: mail-password
- name: globalSettings__mail__smtp__ssl
  valueFrom:
    secretKeyRef:
      name: {{ include "bitwarden.fullname" . }}-global
      key: mail-ssl
- name: globalSettings__mail__smtp__port
  valueFrom:
    secretKeyRef:
      name: {{ include "bitwarden.fullname" . }}-global
      key: mail-port
- name: globalSettings__mail__smtp__useDefaultCredentials
  valueFrom:
    secretKeyRef:
      name: {{ include "bitwarden.fullname" . }}-global
      key: mail-use-default-credentials
- name: globalSettings__disableUserRegistration
  valueFrom:
    secretKeyRef:
      name: {{ include "bitwarden.fullname" . }}-global
      key: disable-user-registration
- name: adminSettings__admins
  valueFrom:
    secretKeyRef:
      name: {{ include "bitwarden.fullname" . }}-global
      key: admins
{{- end -}}
