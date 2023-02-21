#!/bin/bash

taskid=$1
shift
command="$@"

# 1. touch a taskfile indicating the task has begun
# 2. run the command
# 3. if the command succeeds, touch a taskfile indicating the task is done

taskfile_base="taskfiles/$taskid"
mkdir -p $(dirname $taskfile_base)

touch "$taskfile_base.BEGUN"
$command

if [ $? -eq 0 ]; then
  touch "$taskfile_base.DONE"
fi

exit 0
