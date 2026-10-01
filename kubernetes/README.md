# Admin on local Kubernetes

Deploy the shared infrastructure, API, ET1 and ET3 first. Admin shares the API
primary and GoodJob databases, and connects to the ET1 and ET3 databases.
Its menu loads ET3 models, so an absent ET3 database prevents the UI rendering.

From `systems/admin`:

```sh
../../bin/kubernetes up
../../bin/kubernetes status
../../bin/kubernetes logs
```

Open <https://admin.k8s.orb.local/>. Local example login: `admin` / `password`.
The existing Compose startup script `bin/run_full_system` seeds users and
permissions, then starts the web server. It does not run application migrations.
Local values use `RAILS_ENV=production` and `SEED_EXAMPLE_USERS=true`.
The default context is `orbstack`; context, domain and port options work as for
other services. Use `up --build` to build the current checkout.

API operations use the internal API Service URL, with the same `/api` and
`/et_acas_api` paths as Compose. Active Storage proxy downloads use internal
Azurite. CCD browser links use `CCD_UI_BASE_URL` in `values.local.yaml`; adjust
this value when changing the support ingress domain or HTTPS port.

Redis is deliberately absent. The legacy Sidekiq page is expected to fail and
is being removed separately. The GoodJob UI uses the existing queue database.
No application source or production chart values are changed.

Verified via an authenticated HTTP session: dashboard, claim list, submitted
claim details, GoodJob UI and download of a generated PDF from Azurite. These
checks used existing UI routes rather than database console queries.
