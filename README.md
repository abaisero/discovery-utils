# discovery-utils
utilities to run and look at experiments on discovery

Folders and files:

- `bin_slurm/` contains utility scripts to aggregate slurm data in useful ways
- `bin_experiment/` contains utility scripts to run experiments effectively
- `example_experiment.sh/` an example of how to set up an experiment script
- `example_job.sbatch/` an example of how to set up a sbatch job script
- `source_this_to_add_path.sh/` briefly adds bin directories to your PATH

## how to use the scripts

Make sure to include both bin folders to your PATH.  To test the example
experiment, you can temporarily source the `source_this_to_add_path.sh`
script which adds the bin folders to your PATH.

## how to run experiments

To run experiments, you need to create an experiment and a job script.  The
experiment script generated tasks and pipes them along to the utilities
contained in this repo, while the job script is a sbatch template which
contains your sbatch default options of choice.

The repository contains one example of each script which you should be able to
use as an example and as a template for your own versions.

## running the example experiment

First, make sure your environment has the right $PATH variable, e.g.,

```bash
source source_this_to_add_path.sh
```

Then, run the experiment script

```bash
./example_experiment.sh
```

You'll note a large number of sbatch jobs being run.  Each job itself runs
multiple tasks, with each task being allocated 1 CPU, and requiring only a few
seconds to complete.  In total, you should be able to run about 1000 tasks
concurrently using this method.  Running the example script will create the
following directories:

- `jobfiles/` contains the files which indicate how tasks are split into jobs 
- `outputs/` contains the outputs of the individual jobs (usually just error messages, since the individual task outputs are redirected to the `tasklogs/` folder)
- `tasklogs/` contains the outputs of the individual tasks
- `taskfiles/` contains files indicating which tasks have started which have completed (respectively indivated with a BEGUN file and a DONE file)

About half of the example tasks will "fail", meaning that they will not be
marked as being completed with the corresponding DONE file.  When all jobs are
done, you can rerun the experiment script, which will only rerun the tasks
which did not complete already.  Each time you do this, the total number of
tasks and jobs should approximately halve, until there are none left to run.
This is all handled for you; all you have to do is periodically rerun

```bash
./example_experiment.sh
```

## understanding the framework

to use this framework for your more complicated tasks, you should know and notice the following:

* notice that the `example_experiment.sh` is primarily comprised of a big loop (which could also be a few nested loops), each of which echoes a (task-id, task-command) pair.  The task-id should be unique to each task, while the task-command can be any command representing your task.  Notice that the task-command is a call to `example_task.py`, and that the output produced by the whole for loop is redirected to `filter_tasks.sh`, and then to `group_tasks.sh`.

- `filter_tasks.sh` filters all the lines which are associated with a task which has been tagged as having already completed, which can be determined by looking for the DONE file associated with the task-id in the `taskfiles/` folder.

- `group_tasks.sh` takes all the remaining tasks, groups them into chunks of the given size, and runs each group of tasks as a single job using the `example_job.sbatch` file (which you'll notice was given as input in the `example_experiment.sh` script).

- `example_task.py` runs individual tasks.  If there is any chance that your tasks will take more than 24h to run, you'll have to manage your own checkpointing system to make sure that the same task is able to pick up the computation from the right moment.  IMPORTANT: to make the whole framework work, the command MUST return 0 only when the task is complete, and a non-0 value when the task is not complete (e.g., if the time-limit has been reached).  An exit value of 0 indicates that the task has completed successfully, that the DONE file associated with this task should be created, and that future calls to the experiment script should not restart this task again.

## creating your own experiments

To run your own experiments in this framework, you should mostly just do the following:

- create your own task commands, e.g., with your own `task.py`
- create your own `experiment.sh` script which outputs task-id and task-commands as shown in the example script, and selects the `job.sbatch` script to use
- create your own `job.sbatch` script, taking the example one as a template and following the instructions inside
