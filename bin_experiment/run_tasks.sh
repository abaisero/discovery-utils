#!/bin/bash

# read input lines (1 line = 1 task)
while read line; do
  line=($line)

  taskid=${line[0]}
  taskcommand=${line[@]:1}

  logfile="tasklogs/$taskid.log"
  mkdir -p $(dirname $logfile)
  srun --ntasks 1 --nodes 1 --exclusive run_task.sh ${line[@]} &>> $logfile &
done

wait

exit 0
