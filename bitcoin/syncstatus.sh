#!/bin/bash

localhost_block=1000 #$(bitcoin-cli --conf=/etc/bitcoin/bitcoin.conf getblockchaininfo | jq -r '.blocks')
localhost_synced=true #$(bitcoin-cli --conf=/etc/bitcoin/bitcoin.conf getindexinfo | jq -r '.synced')

# Fetch latest block from blockchain.info with proper error handling
mainchain_block=$(curl -s -m 10 -H "Content-Type: application/json" \
      "https://blockchain.info/latestblock" | jq -r '.block_index')

# Check if values were retrieved successfully
if [[ -z "$mainchain_block" || -z "$localhost_block" ]]; then
  echo "Error: Could not retrieve block numbers."
  exit 1
fi

# Calculate sync percentage (capped at 100%)
sync_pct=$(awk -v local="$localhost_block" -v main="$mainchain_block" 'BEGIN { pct = (local / main) * 100; print (pct > 99 ? 99 : (pct < 0 ? 0 : pct)) }' | xargs printf "%.2f")

if [ "$localhost_synced" = "true" ]; then
  sync_pct=$(awk -v n="$sync_pct" 'BEGIN { printf "%.2f", n + 1 }')
fi

echo "$sync_pct%"
