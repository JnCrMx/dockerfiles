#!/bin/bash

set -eu

mkdir -p "$OUT"/

ARCH=$(arch)
if ! [ "$ARCH" = "amd64" ] ; then
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y box64

    for b in $BINS ; do
        name=$(basename $b)
        outpath="$OUT"/"$name"

        echo "#!/bin/bash" > "$outpath"
        echo "box64 \"$b\" \"\$@\"" >> "$outpath"
        chmod +x "$outpath"
    done
else
    for b in $BINS ; do
        ln -s "$b" "$OUT"/
    done
fi
