#!/bin/bash

filepath=$(readlink -f "${BASH_SOURCE:-$0}")
dirpath=$(dirname "$filepath")

export PATH="$dirpath/bin_slurm:$PATH"
export PATH="$dirpath/bin_experiments:$PATH"

export TASK_BEGUN="TASK.BEGUN"
export TASK_DONE="TASK.DONE"
