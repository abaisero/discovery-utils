#!/bin/bash

experiment_id=$1
shift
task_id=$1
shift
task_command="$@"

# 1. touch a task_file indicating the task has begun
# 2. run the task_command
# 3. if the task_command succeeds, touch a task_file indicating the task is done

task_path=$(make_task_path.sh $experiment_id $task_id)

cd $task_path

touch $TASK_BEGUN
$task_command

if [ $? -eq 0 ]; then
  touch $TASK_DONE
fi
