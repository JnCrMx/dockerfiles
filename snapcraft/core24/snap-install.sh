#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <snap-name>"
  exit 1
fi

# Check for $ARCH
if [ -z "$ARCH" ]; then
  echo "ARCH is not set. Please set it to your system architecture (e.g., amd64, arm64)."
  exit 1
fi

# check for jq command
if ! command -v jq &> /dev/null; then
  echo "jq could not be found, please install it."
  exit 1
fi
# check for unsquashfs command
if ! command -v unsquashfs &> /dev/null; then
  echo "unsquashfs could not be found, please install it."
  exit 1
fi
# check for curl command
if ! command -v curl &> /dev/null; then
  echo "curl could not be found, please install it."
  exit 1
fi

SNAPNAME=$1

url="$(curl -s -H 'X-Ubuntu-Series: 16' -H "X-Ubuntu-Architecture: $ARCH" "https://api.snapcraft.io/api/v1/snaps/details/$SNAPNAME" | jq '.download_url' -r)"
curl -L -H 'X-Ubuntu-Series: 16' -H "X-Ubuntu-Architecture: $ARCH" "$url" -o "$SNAPNAME.snap"
if [ $? -ne 0 ]; then
  echo "Failed to download $SNAPNAME"
  exit 1
fi

mkdir -p /snap/"$SNAPNAME"
unsquashfs -d /snap/$SNAPNAME/current $SNAPNAME.snap
if [ $? -ne 0 ]; then
  echo "Failed to unsquash $SNAPNAME"
  exit 1
fi

rm $SNAPNAME.snap
