#!/bin/bash

task_id=$1
shift
command="$@"

# 1. touch a task_file indicating the task has begun
# 2. run the command
# 3. if the command succeeds, touch a task_file indicating the task is done

task_file_base="task_files/$task_id"
mkdir -p $(dirname $task_file_base)

touch "$task_file_base.BEGUN"
$command

if [ $? -eq 0 ]; then
  touch "$task_file_base.DONE"
fi
