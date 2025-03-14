#!/bin/bash

filepath=$(readlink -f "${BASH_SOURCE:-$0}")
dirpath=$(dirname "$filepath")

export PATH="$dirpath/bin-slurm:$PATH"
export PATH="$dirpath/bin-experiments:$PATH"

export TASK_BEGUN="TASK.BEGUN"
export TASK_DONE="TASK.DONE"
