FROM ubuntu:latest

# Moving from separate apt installs to a combined
# Before: 160MB
# After: 132MB
# Verdict: Passed.

# Install packages
# Adding --no-install-recommends
# Before: 132MB
# AFter: 130MB
# Verdict: Passed.
RUN apt-get update && \
    apt-get install -y curl \
    htop \
    jq \
    iproute2 \
    iputils-ping \
    net-tools \
    socat

RUN mkdir -p /root/.config/htop/
COPY htoprc /root/.config/htop/htoprc

# This is an optimization to reduce image size, I only need english
# Before: 139mb
# AFter: 160mb
# Verdict: Failed.
#RUN apt-get update && apt-get install -y locales \
#    && locale-gen en_US.UTF-8 \
#    && locale-gen en_US \
#    && update-locale LANG=en_US.UTF-8 LANGUAGE=en_US \
#    && rm -rf /usr/share/locale/* \
#    && rm -rf /var/cache/debconf/*old

# Removing '/var/cache/apt/archives/*'
# Before: 132MB
# After: 132MB
# Verdict: Failed.

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* \



