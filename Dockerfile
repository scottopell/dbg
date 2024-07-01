FROM debian:unstable-slim

# Install packages
RUN apt-get update && \
    apt-get install -y \
    bpftrace \
    curl \
    htop \
    jq \
    iproute2 \
    iputils-ping \
    python3 \
    net-tools \
    socat

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*
