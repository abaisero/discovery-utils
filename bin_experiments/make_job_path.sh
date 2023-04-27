#!/bin/bash

experiment_id=$1
shift
timestamp=$1
shift
job_id=$1
shift

experiment_path=$(make_experiment_path.sh $experiment_id)
echo "$experiment_path/jobs/$timestamp/$job_id"
