#!/usr/bin/env python
import argparse
import random
import time


def task(task_id: int, *, task_seconds) -> int:
    """runs task, and returns 0 iff task is done"""

    print(f'task {task_id} start')
    time.sleep(task_seconds)

    task_code = int(random.random() < 0.5)
    if task_code == 0:
        print(f'task {task_id} done')
    else:
        print(f'task {task_id} NOT done yet')

    return task_code


def main() -> int:
    """parses arguments, runs task, return exit code"""

    parser = argparse.ArgumentParser('Example task script')
    parser.add_argument('task_id', type=int)
    parser.add_argument('--task-seconds', type=float, default=10.0)
    args = parser.parse_args()

    return task(args.task_id, task_seconds=args.task_seconds)


if __name__ == '__main__':
    raise SystemExit(main())
