ARG UBUNTU_VERSION=noble

FROM ubuntu:${UBUNTU_VERSION}
ARG UBUNTU_VERSION=noble
ARG LLVM_VERSION=17

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates wget gnupg && \
        wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
        echo "deb [arch=arm64] http://apt.llvm.org/"${UBUNTU_VERSION}"/ llvm-toolchain-"${UBUNTU_VERSION}"-"${LLVM_VERSION}" main" > /etc/apt/sources.list.d/llvm.list && \
        apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        clang-${LLVM_VERSION} lld-${LLVM_VERSION} cmake ninja-build libstdc++-12-dev \
        git patch ssh-client ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN ln -sf /usr/bin/ld.lld-${LLVM_VERSION} /usr/bin/ld && \
    ln -sf /usr/bin/clang-${LLVM_VERSION} /usr/bin/clang && \
    ln -sf /usr/bin/clang++-${LLVM_VERSION} /usr/bin/clang++ && \
    ln -sf /usr/bin/clang-${LLVM_VERSION} /usr/bin/cc && \
    ln -sf /usr/bin/clang++-${LLVM_VERSION} /usr/bin/c++

ENV CMAKE_GENERATOR=Ninja
