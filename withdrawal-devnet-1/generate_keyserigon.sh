#!/bin/bash


if [ -z "$VALIDATORS_MNEMONIC_0" ]; then
  echo "missing mnemonic 0"
  exit 1
fi

function prep_group {
  let group_base=$1
  validators_source_mnemonic="$2"
  let offset=$3
  let keys_to_create=$4
  naming_prefix="$5"
  validators_per_host=$6
  echo "Group base: $group_base"
  for (( i = 0; i < keys_to_create; i++ )); do
    let node_index=group_base+i
    let offset_i=offset+i
    let validators_source_min=offset_i*validators_per_host
    let validators_source_max=validators_source_min+validators_per_host

    echo "writing keystores for host $naming_prefix-$node_index: $validators_source_min - $validators_source_max"
    eth2-val-tools keystores \
    --insecure \
    --prysm-pass="prysm" \
    --out-loc="validator_prep/$naming_prefix-$node_index" \
    --source-max="$validators_source_max" \
    --source-min="$validators_source_min" \
    --source-mnemonic="$validators_source_mnemonic"
  done
}

prep_group 1 "$VALIDATORS_MNEMONIC_0" 0 1 "withdrawal-devnet-1-lighthouse-erigon" 100
prep_group 1 "$VALIDATORS_MNEMONIC_0" 1 1 "withdrawal-devnet-1-prysm-erigon" 100
prep_group 1 "$VALIDATORS_MNEMONIC_0" 2 1 "withdrawal-devnet-1-teku-erigon" 100
prep_group 1 "$VALIDATORS_MNEMONIC_0" 3 1 "withdrawal-devnet-1-lodestar-erigon" 100
prep_group 1 "$VALIDATORS_MNEMONIC_0" 4 1 "withdrawal-devnet-1-nimbus-erigon" 100