#!/bin/bash

# Function to get block number from a given URL
get_block_number() {
  local url=$1
  curl -s -H "Content-Type: application/json" \
       -d '{"jsonrpc":"2.0","id":1,"method":"chain_getHeader","params":[]}' \
       "$url" | jq -r '.result.number' | xargs printf "%d\n"
}

# Get block numbers
mainchain_block=$(get_block_number "https://rpc.argon.network")
localhost_block=$(get_block_number "http://localhost:9944")

# Check if values were retrieved successfully
if [[ -z "$localhost_block" || -z "$mainchain_block" ]]; then
  echo "Error: Could not retrieve block numbers."
  exit 1
fi

# Calculate sync percentage (capped at 100%)
sync_pct=$(awk -v local="$localhost_block" -v main="$mainchain_block" 'BEGIN { pct = (local / main) * 100; print (pct > 100 ? 100 : pct) }' | xargs printf "%.2f")
echo "$sync_pct%"
