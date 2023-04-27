#!/bin/bash

# read input lines (1 line = 1 task)
while read line; do
  line=($line)

  task_id=${line[0]}
  task_command=${line[@]:1}

  log_file="task_logs/$task_id.log"
  mkdir -p $(dirname $log_file)
  # TODO what is happening here with the line?  why am I not using task_command?
  srun --ntasks 1 --nodes 1 --exclusive run_task.sh ${line[@]} &>> $log_file &
done

wait
