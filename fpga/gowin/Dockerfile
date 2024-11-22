FROM ubuntu:noble

ARG VERSION=V1.9.10.03
ARG TARGETARCH

ADD https://cdn.gowinsemi.com.cn/Gowin_V1.9.10.03_linux.tar.gz /tmp/gowin.tar.gz
RUN mkdir -p /opt/gowin && \
    tar -C /opt/gowin -xvzf /tmp/gowin.tar.gz && \
    rm /tmp/gowin.tar.gz
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y libglib2.0-0 libfontconfig1 libfreetype6 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN --mount=target=/build,source=build \
    BINS="/opt/gowin/IDE/bin/gw_ide /opt/gowin/IDE/bin/gw_sh" \
    OUT="/opt/gowin/bin" \
    /build/box64.sh

ENV PATH="/opt/gowin/bin:${PATH}"
ENV LD_PRELOAD="/usr/lib/\${PLATFORM}-linux-gnu/libfreetype.so.6"
