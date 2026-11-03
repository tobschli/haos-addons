#!/bin/sh
# Options are injected by the Supervisor as environment variables.
url="${URL:-${url:-https://information.konamisportsclub.jp/ksc/004479/}}"
port="${LISTEN_PORT:-${listen_port:-2112}}"

echo "Starting konzatsu on port ${port} (scraping ${url})"
exec /usr/bin/konzatsu -url "${url}" -listen ":${port}"
