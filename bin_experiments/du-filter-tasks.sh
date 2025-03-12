#!/bin/bash

while read -r -a line; do
  experiment_id=${line[0]}
  task_id=${line[1]}
  # task_command=${line[@]:2}

  task_path=$(make-path.py task "$experiment_id" "$task_id")
  # task_file_begun="$task_path/$TASK_BEGUN"
  task_file_done="$task_path/$TASK_DONE"

  # filter task if the task is registered as DONE
  if [[ ! -f "$task_file_done" ]]; then
    echo "${line[@]}"
  fi

done
