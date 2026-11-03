# haos-addons

My **single Home Assistant add-on repository** — add it in Home Assistant under
**Settings → Add-ons → Add-on Store → ⋮ → Repositories**, once, for everything.

Style follows [alexbelgium/hassio-addons](https://github.com/alexbelgium/hassio-addons):
each add-on is a folder at the repo root with its own `Dockerfile` that packages
the application's prebuilt image, plus `config.yaml`, `DOCS.md` and `run.sh`.
No app source code lives here — code stays in the app repos.

## How a release reaches Home Assistant

1. **App repo** (e.g. [tobschli/konzatsu](https://github.com/tobschli/konzatsu)):
   tag a version (`git tag v1.0.5 && git push --tags`). Its release workflow
   builds one multi-arch image: `ghcr.io/tobschli/konzatsu:<version>`.
2. **This repo, `bump-versions.yml`** (weekly cron, or run manually):
   reads the app repo's latest release (or, if none, its latest `v*` tag),
   bumps `version:` in the add-on's `config.yaml` and the matching `ARG` in
   its `Dockerfile`, commits.
3. **This repo, `onpush_builder.yaml`** (on every push):
   builds each changed add-on folder and pushes
   `ghcr.io/tobschli/<slug>-{amd64,aarch64}:<version>` images.
4. **Home Assistant**: deploys the prebuilt image; nothing is built on the
   Supervisor.

You can also trigger steps 2–3 immediately: run the workflows manually
(`gh workflow run bump-versions.yml` etc.).

## Adding a new add-on (own app)

1. App repo: build & release a multi-arch image on tag push.
2. Here: create `<slug>/` with `config.yaml` (version = app release,
   `image: ghcr.io/tobschli/<slug>-{arch}`), `Dockerfile`
   (`ARG`, `FROM alpine`, `COPY --from=<app image>` the binary, `COPY run.sh`),
   an executable `run.sh` that reads options from env vars, and `DOCS.md`.
3. Add the slug to the list in `.github/workflows/bump-versions.yml`.
4. Add a row to the table below.

## Add-ons

| Add-on | Source repo | Description |
| --- | --- | --- |
| [Konzatsu](konzatsu/DOCS.md) | https://github.com/tobschli/konzatsu | Prometheus exporter for KONAMI Sports Club congestion levels |
