#!/bin/bash

num_tasks=1000
num_tasks_per_job=20

sbatch_args=(
  --job-name example-job
  example_job.sbatch
)

for i in $(seq $num_tasks); do
  i=$(printf "%04d" $i)

  # create unique task id
  taskid="example-task.$i"

  # create task command
  taskcommand="./example_task.py $i"

  # echo task id and command
  echo "$taskid $taskcommand"

done | filter_tasks.sh | group_tasks.sh $num_tasks_per_job "${sbatch_args[@]}"

exit 0
