# chatwit_server

## Run locally

The development Compose file reads `DB_PASSWORD` from the repository-root
`.env` file. Copy `.env.example` to `.env` in the repository root and replace
the placeholder with a local-only password. PostgreSQL keeps its initial
password in its data volume; changing `.env` later does not change the password
of an already initialized database.

In PowerShell, set the same value for Serverpod before starting the containers
and server (replace the example with the value from `.env`):

```powershell
$env:DB_PASSWORD = "your-local-only-password"
$env:SERVERPOD_PASSWORD_database = $env:DB_PASSWORD
$env:SMTP_FROM_EMAIL = "your-verified-sender@example.com"
docker compose -f chatwit_server/docker-compose.yaml up --build --detach
Set-Location chatwit_server
dart bin/main.dart
```

Run the Compose command from the repository root, then change to
`chatwit_server` before starting Serverpod so it loads this package's
configuration. Keep using the same PowerShell session so Compose and Serverpod
inherit the matching values. Compose reads the root `.env` file as well. Set
`sendgridApiKey` in `config/passwords.yaml` and `SMTP_FROM_EMAIL` in the
environment of the Serverpod process. The sender address must be verified with
SendGrid. Keep credentials private and do not commit them. Verification emails
are sent through SendGrid's HTTPS API.

To run server integration tests, keep `SMTP_FROM_EMAIL` set and run `dart test`
from `chatwit_server`. Tests use the separate PostgreSQL test service on port
9090; they do not need Redis. Do not remove Docker volumes if they contain data
you need.

To regenerate the Serverpod client and protocol after changing endpoints or
models, install the matching CLI and run the generator:

```sh
dart pub global activate serverpod_cli 4.0.4
cd chatwit_server
serverpod generate
```

For real Firebase Cloud Messaging delivery, add the Firebase Admin service-account
JSON from the Firebase console to `config/passwords.yaml` under the active
Serverpod environment as `firebaseServiceAccount`. The service account must have
the Firebase Cloud Messaging API enabled.

When finished, shut down Serverpod with `Ctrl-C`, then stop the containers from
the repository root:

```powershell
Set-Location ..
docker compose -f chatwit_server/docker-compose.yaml stop
```
