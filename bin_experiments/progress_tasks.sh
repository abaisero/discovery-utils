#!/bin/bash

experiment_id=$1
shift

ntasks=$(find task_files/ -name "$experiment_id*.BEGUN" -maxdepth 1 -type f | wc -l)
ndone=$(find task_files/ -name "$experiment_id*.DONE" -maxdepth 1 -type f | wc -l)

printf "%4d / %4d tasks done\n" $ndone $ntasks

exit
