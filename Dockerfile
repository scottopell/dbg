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
    net-tools \
    socat

RUN mkdir -p /root/.config/htop/
COPY htoprc /root/.config/htop/htoprc

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*
