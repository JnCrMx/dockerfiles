#!/bin/bash

DEFAULT_LICENSE_PATH="/opt/gowin/floating.lic"
LICENSE_PATH="${GOWIN_LICENSE_PATH:-$DEFAULT_LICENSE_PATH}"

if [ ! -z "$GOWIN_LICENSE" ]; then
    LICENSE_PATH="$(mktemp --tmpdir gowin-floating.XXXXXX.lic)"
    echo "$GOWIN_LICENSE" > "$LICENSE_PATH"
fi

echo "Using license file: $LICENSE_PATH"
license_server -s "$LICENSE_PATH"
