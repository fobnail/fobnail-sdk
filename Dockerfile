FROM debian:oldstable-20220125-slim

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    libusb-1.0-0-dev \
    libftdi1-dev \
    pkg-config \
    libudev-dev \
    iproute2 \
    net-tools \
    iputils-ping \
    iptables \
    curl \
    gcc \
    llvm-7 \
    libclang1-7 \
    clang \
    gcc-arm-none-eabi \
    libnewlib-arm-none-eabi \
    ca-certificates \
    sudo \
    gosu \
    python3-pip \
    git \
    xz-utils && \
    apt-get clean && \
    pip3 install pre-commit && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    SHELLCHECK_VERSION=0.8.0

RUN curl -L --proto '=https' --tlsv1.2 -sSf \
    https://github.com/koalaman/shellcheck/releases/download/v${SHELLCHECK_VERSION}/shellcheck-v${SHELLCHECK_VERSION}.linux.x86_64.tar.xz \
    -o /tmp/shellcheck.tar.xz && \
    cd /tmp && \
    tar xf shellcheck.tar.xz && \
    cp shellcheck-v${SHELLCHECK_VERSION}/shellcheck /usr/local/bin && \
    rm -rf shellcheck.tar.xz shellcheck-v${SHELLCHECK_VERSION}

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o /tmp/rustup-init && \
    chmod +x /tmp/rustup-init && \
    /tmp/rustup-init -y --no-modify-path \
        --default-toolchain nightly-2022-08-09 \
        -t thumbv7em-none-eabihf \
        -c llvm-tools-preview \
        && \
    rm /tmp/rustup-init

RUN cargo install --version 0.12.0 cargo-embed && \
    cargo install --version 0.12.0 probe-rs-cli && \
    rm -rf /usr/local/cargo/registry

RUN echo "builder ALL=NOPASSWD: ALL" > /etc/sudoers.d/builder-nopasswd && \
    chmod 660 /etc/sudoers.d/builder-nopasswd

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
