FROM ghcr.io/argonprotocol/argon-miner:v1.1.0

USER root
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    && rm -rf /var/lib/apt/lists/*

COPY syncstatus.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/syncstatus.sh

COPY latestblock.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/latestblock.sh

USER argon
