# syntax = docker/dockerfile:latest

FROM --platform=linux/amd64 debian
LABEL org.opencontainers.image.source https://github.com/argonprotocol/argon-commander-deploy

RUN <<END
    set -ex
    apt-get update
    apt-get install -y wget curl jq
    wget https://bitcoincore.org/bin/bitcoin-core-28.0/bitcoin-28.0-x86_64-linux-gnu.tar.gz
    tar xzf bitcoin-28.0-x86_64-linux-gnu.tar.gz
    install -m 0755 -o root -g root -t /usr/local/bin bitcoin-28.0/bin/*
END

COPY ./bitcoin.conf /etc/bitcoin/bitcoin.conf
COPY ./bitcoin-signet.conf /etc/bitcoin/bitcoin-signet.conf
COPY ./entrypoint.sh /

COPY syncstatus.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/syncstatus.sh

ENTRYPOINT [ "./entrypoint.sh" ]
CMD [ "/usr/local/bin/bitcoind", "-conf=/etc/bitcoin/bitcoin.conf" ]
