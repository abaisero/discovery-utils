#!/bin/bash

while read -r -a line; do
  experiment_id=${line[0]}
  task_id=${line[1]}
  # task_command=${line[@]:2}

  task_path=$(make-path.py task "$experiment_id" "$task_id")
  mkdir -p "$task_path"

  task_output="$task_path/output.txt"

  srun --ntasks 1 --nodes 1 --exclusive run_task.sh "${line[@]}" &>> "$task_output" &
done

wait
