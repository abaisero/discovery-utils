#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Script requires wandb/ folder as argument"
  exit 1
fi

path=$1
shift

for runfile in $(find "$path" -name 'run-*.wandb'); do
  if [ ! -f "$runfile.synced" ]; then
    echo $runfile
  fi
done \
  | xargs --no-run-if-empty basename --multiple --suffix .wandb \
  | sort | uniq \
  | cut --characters=5- - \
