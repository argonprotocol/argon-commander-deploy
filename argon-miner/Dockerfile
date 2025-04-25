FROM ghcr.io/argonprotocol/argon-miner:1.1.0-rc.4

USER root
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    && rm -rf /var/lib/apt/lists/*

COPY syncstatus.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/syncstatus.sh

USER argon
