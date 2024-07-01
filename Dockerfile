# Use the latest Ubuntu LTS
FROM ubuntu:latest

# Install packages
RUN apt-get update && \
    apt-get install -y \
    bpftrace \
    curl \
    net-tools \
    socat \
    iputils-ping \
    iproute2

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*
