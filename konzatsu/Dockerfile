# Built by Supervisor or CI. KONZATSU_VERSION must match the version
# published by tobschli/konzatsu; the bump-versions workflow keeps it in sync.
ARG KONZATSU_VERSION=1.1.0

FROM ghcr.io/tobschli/konzatsu:${KONZATSU_VERSION} AS app
FROM alpine:3.22
COPY --from=app /konzatsu /usr/bin/konzatsu
COPY run.sh /
ENTRYPOINT ["/run.sh"]
