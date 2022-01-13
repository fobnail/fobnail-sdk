FROM debian:buster-slim

RUN apt-get update && apt-get install -y \
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
    && \
    rm -rf /var/lib/apt/lists/*

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o /tmp/rustup-init && \
    chmod +x /tmp/rustup-init && \
    /tmp/rustup-init -y --no-modify-path \
        --default-toolchain nightly-2022-01-13 \
        -t thumbv7em-none-eabihf && \
    rm /tmp/rustup-init

RUN cargo install cargo-embed && cargo install probe-rs-cli && \
    rm -rf /usr/local/cargo/registry

RUN useradd -ms /bin/bash build && \
    usermod -aG sudo,dialout build && \
    echo 'export CARGO_HOME=~/.cargo' >> /home/build/.bashrc

USER build
WORKDIR /home/build
