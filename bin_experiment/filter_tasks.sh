#!/bin/bash

while read -r line; do
  line=($line)

  taskid=${line[0]}
  taskcommand=${line[@]:1}

  taskfile_start="taskfiles/$taskid.BEGUN"
  taskfile_done="taskfiles/$taskid.DONE"

  # filter task if the task is registered as DONE
  if [[ ! -f "$taskfile_done" ]]; then
    echo $taskid $taskcommand
  fi

done
