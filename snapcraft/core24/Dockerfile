FROM ubuntu:jammy AS builder
ENV DEBIAN_FRONTEND=noninteractive
ARG TARGETARCH

# Grab dependencies
RUN apt-get update
RUN apt-get dist-upgrade --yes
RUN apt-get install --yes \
      curl \
      jq \
      squashfs-tools

ADD ./snap-install.sh /usr/bin/snap-install.sh

# download and extract core22 (required for snapcraft to run)
RUN ARCH=$TARGETARCH snap-install.sh core22

# download and extract snapcraft
RUN ARCH=$TARGETARCH snap-install.sh snapcraft

# Fix Python3 installation: Make sure we use the interpreter from
# the snapcraft snap:
RUN unlink /snap/snapcraft/current/usr/bin/python3
RUN ln -s /snap/snapcraft/current/usr/bin/python3.* /snap/snapcraft/current/usr/bin/python3
RUN echo /snap/snapcraft/current/lib/python3.*/site-packages >> /snap/snapcraft/current/usr/lib/python3/dist-packages/site-packages.pth

# Create a snapcraft runner
RUN mkdir -p /snap/bin
RUN echo "#!/bin/sh" > /snap/bin/snapcraft
RUN snap_version="$(awk '/^version:/{print $2}' /snap/snapcraft/current/meta/snap.yaml | tr -d \')" && echo "export SNAP_VERSION=\"$snap_version\"" >> /snap/bin/snapcraft
RUN echo 'exec "/snap/snapcraft/current/bin/python3" -m snapcraft "$@"' >> /snap/bin/snapcraft
RUN chmod +x /snap/bin/snapcraft

# download and extract core24
RUN ARCH=$TARGETARCH snap-install.sh core24

FROM ubuntu:noble
ENV DEBIAN_FRONTEND=noninteractive

COPY --from=builder /snap/core22 /snap/core22
COPY --from=builder /snap/core24 /snap/core24
COPY --from=builder /snap/snapcraft /snap/snapcraft
COPY --from=builder /snap/bin/snapcraft /snap/bin/snapcraft

# Generate locale and install dependencies.
RUN apt-get update && apt-get dist-upgrade --yes && apt-get install --yes snapd sudo locales git binutils curl jq squashfs-tools && locale-gen en_US.UTF-8
ADD ./snap-install.sh /usr/bin/snap-install.sh
RUN mkdir /snap/snapcraft/current/usr/share/snapcraft/keyrings \
    /snap/snapcraft/current/usr/share/snapcraft/extensions \
    /snap/snapcraft/current/usr/share/snapcraft/plugins \
    /snap/snapcraft/current/usr/share/snapcraft/schema -p
# Set the proper environment.
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US:en"
ENV LC_ALL="en_US.UTF-8"
ENV PATH="/snap/snapcraft/current/libexec/snapcraft/:/snap/bin:$PATH"
ENV SNAPCRAFT_BUILD_ENVIRONMENT=host
