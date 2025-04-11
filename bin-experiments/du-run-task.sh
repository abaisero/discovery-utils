#!/bin/bash

experiment_id=$1
shift
task_id=$1
shift
task_command="$*"

# 1. touch a task_file indicating the task has begun
# 2. run the task_command
# 3. if the task_command succeeds, touch a task_file indicating the task is done

task_path=$(du-make-path.py task "$experiment_id" "$task_id")

(
  cd "$task_path" || exit 1

  touch "$TASK_BEGUN"
  echo "RUNNING $task_command"

  if $task_command; then
    touch "$TASK_DONE"
  fi
)
