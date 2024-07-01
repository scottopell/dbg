#!/bin/bash

# Initialize a new git repository
git init

# Create a Dockerfile
cat <<EOF >Dockerfile
# Use the latest Ubuntu LTS
FROM ubuntu:latest

# Install packages
RUN apt-get update && \\
    apt-get install -y \\
    bpftrace \\
    curl \\
    net-tools \\
    socat \\
    iputils-ping \\
    iproute2

# Clean up
RUN apt-get clean && \\
    rm -rf /var/lib/apt/lists/*
EOF

# Create a .github/workflows directory
mkdir -p .github/workflows

# Create a GitHub Actions workflow file
cat <<EOF >.github/workflows/build-and-push.yml
name: Build and Push Docker Image

on:
  push:
    branches:
      - 'main'

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout Code
      uses: actions/checkout@v3

    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v2

    - name: Login to GitHub Container Registry
      uses: docker/login-action@v2
      with:
        registry: ghcr.io
        username: \${{ github.actor }}
        password: \${{ secrets.GITHUB_TOKEN }}

    - name: Build and push Docker image
      uses: docker/build-push-action@v3
      with:
        context: .
        file: ./Dockerfile
        push: true
        tags: ghcr.io/\${{ github.repository }}/my-network-tools:latest
EOF

# Add all files to the repository
git add .

# Commit the changes
git commit -m "Initial commit with Dockerfile and GitHub Actions configuration"

echo "Repository initialized and configured with Docker and GitHub Actions."
