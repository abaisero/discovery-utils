#!/bin/bash

filepath=$(readlink -f "${BASH_SOURCE[@]}")
dirpath=$(dirname $filepath)

export PATH="$dirpath/bin_slurm:$PATH"
export PATH="$dirpath/bin_experiments:$PATH"
