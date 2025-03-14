#!/bin/bash

experiment_path=$1
shift

ntasks=$(find "$experiment_path" -name "$TASK_BEGUN" -type f | wc -l)
ndone=$(find "$experiment_path" -name "$TASK_DONE" -type f | wc -l)

printf "%4d / %4d tasks done\n" "$ndone" "$ntasks"
