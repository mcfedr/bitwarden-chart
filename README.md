# Bitwarden k8s charts

A chart for deploying bitwarden

## Usage

```bash
helm upgrade bitwarden charts/bitwarden --install -f values.yaml
```

Your values file needs to contain a bunch of stuff, hopefully ill make it easier
to generate the values in the future

```yaml
mssql:
  saPassword: a password

certificates:
  issuer: letsencrypt-prod-dns
  kind: Issuer
  type: dns01
  options:
    provider: prod-dns

global:
  host: bitwarden.example.com
  internalIdentityKey: Generated key
  duoKey: Generated key
  installationId: Generated uuid install id
  installationKey: and matching key
  mail:
    replyToEmail: bitwarden@example.com
    host: exmaple.com
    username: bitwarden@example.com
    password: a password
    ssl: "true"
    port: "587"
    useDefaultCredentials: "false"
  disableUserRegistration: "false"
  admins: "admin@example.com"

identity:
  certificatePassword: a cert pass
  pfx: your cert in pfx format
```
