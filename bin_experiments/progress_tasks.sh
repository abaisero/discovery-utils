#!/bin/bash

experiment_id=$1
shift

ntasks=$(find task_files/ -name "$experiment_id*.BEGUN" -type f | wc -l)
ndone=$(find task_files/ -name "$experiment_id*.DONE" -type f | wc -l)

printf "%4d / %4d tasks done\n" $ndone $ntasks
