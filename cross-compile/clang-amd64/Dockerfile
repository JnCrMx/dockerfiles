ARG UBUNTU_VERSION=mantic

FROM ubuntu:${UBUNTU_VERSION}
ARG UBUNTU_VERSION=mantic

COPY amd64.list /etc/apt/sources.list.d/amd64.list

RUN dpkg --add-architecture amd64 && \
    sed -i 's/^deb/deb [arch=arm64]/' /etc/apt/sources.list && \
    sed -i "s/UBUNTU_VERSION/"${UBUNTU_VERSION}"/" /etc/apt/sources.list.d/amd64.list
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        clang cmake lld ninja-build libstdc++-12-dev:amd64 && \
    rm -rf /var/lib/apt/lists/*

RUN ln -sf /usr/bin/ld.lld /usr/bin/ld

COPY toolchain.cmake /toolchain.cmake

ENV CMAKE_TOOLCHAIN_FILE=/toolchain.cmake
ENV CMAKE_GENERATOR=Ninja
