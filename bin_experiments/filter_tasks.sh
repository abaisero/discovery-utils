#!/bin/bash

while read -r line; do
  line=($line)

  task_id=${line[0]}
  task_command=${line[@]:1}

  task_file_start="task_file/$task_id.BEGUN"
  task_file_done="task_file/$task_id.DONE"

  # filter task if the task is registered as DONE
  if [[ ! -f "$task_file_done" ]]; then
    echo $experiment_i $task_id $task_command
  fi

done

exit
