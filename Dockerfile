FROM rust AS utils

ENV CARGO_NET_GIT_FETCH_WITH_CLI true

# Stuck in build hell here, repo has a submodule configured with ssh
# either delete it in my fork
# or
# build binaries via github actions and download those binaries in here
RUN git config --global url."https://github".insteadOf git://github && \
    mkdir /t && \
    cargo install --root=/t --git=https://github.com/scottopell/promtool.git --bin promtool

FROM ubuntu:devel AS base

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


RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

FROM scratch

COPY --from=base / /
COPY --from=utils /t/ /usr/local/

CMD ["/bin/bash"]
