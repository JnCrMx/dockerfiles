ARG UBUNTU_VERSION=mantic

FROM ubuntu:${UBUNTU_VERSION}
ARG UBUNTU_VERSION=mantic

COPY amd64.list /etc/apt/sources.list.d/amd64.list

RUN dpkg --add-architecture amd64 && \
    sed -i 's/^deb/deb [arch=arm64]/' /etc/apt/sources.list && \
    sed -i "s/UBUNTU_VERSION/"${UBUNTU_VERSION}"/" /etc/apt/sources.list.d/amd64.list && \
    if [ -f /etc/apt/sources.list.d/ubuntu.sources ]; then \
        sed -i "/Types: deb/a Architectures: arm64" /etc/apt/sources.list.d/ubuntu.sources; \
    fi
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates wget gnupg && \
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    echo "deb [arch=arm64] http://apt.llvm.org/"${UBUNTU_VERSION}"/ llvm-toolchain-"${UBUNTU_VERSION}" main" > /etc/apt/sources.list.d/llvm.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        clang lld cmake ninja-build libstdc++-12-dev:amd64 \
        git patch ssh-client ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN ln -sf /usr/bin/ld.lld /usr/bin/ld && \
    ln -sf /usr/bin/clang /usr/bin/cc && \
    ln -sf /usr/bin/clang++ /usr/bin/c++

COPY toolchain.cmake /toolchain.cmake

ENV CMAKE_TOOLCHAIN_FILE=/toolchain.cmake
ENV CMAKE_GENERATOR=Ninja
