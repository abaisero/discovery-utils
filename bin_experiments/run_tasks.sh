#!/bin/bash

# read input lines (1 line = 1 task)
while read line; do
  line=($line)

  experiment_id=${line[0]}
  task_id=${line[1]}
  task_command=${line[@]:2}

  task_path=$(make_task_path.sh $experiment_id $task_id)
  mkdir -p $task_path

  task_output="$task_path/output.txt"

  srun --ntasks 1 --nodes 1 --exclusive run_task.sh ${line[@]} &>> $task_output &
done

wait
