# Firefox
This is the config that should be changed on Firefox after install.

Go to `about:config` and accept the warning.

## Security 
Deactivate TLS 1.0 and TLS 1.1 by setting `security.tls.version.min` to `3`.

## Certificates
If enterprise root certificates are installed on the machine, set `security.enterprise_roots.enabled` to true.

## Todo 
Script these changes
