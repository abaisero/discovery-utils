#!/usr/bin/env python

import argparse
import pathlib


def make_experiment_path(experiment_id: str, *, absolute: bool) -> pathlib.Path:
    path = pathlib.Path("experiments") / experiment_id

    if absolute:
        path = path.resolve()

    return path


def make_job_path(
    experiment_id: str,
    timestamp: str,
    job_id: str,
    *,
    absolute: bool,
) -> pathlib.Path:
    experiment_path = make_experiment_path(experiment_id, absolute=absolute)
    return experiment_path / "job" / timestamp / job_id


def make_task_path(experiment_id: str, task_id: str, *, absolute: bool) -> pathlib.Path:
    experiment_path = make_experiment_path(experiment_id, absolute=absolute)
    return experiment_path / "task" / task_id


def parse_args():
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest="command")

    subparser = subparsers.add_parser("experiment")
    subparser.add_argument("experiment_id", type=str)
    subparser.add_argument("--absolute", action="store_true")

    subparser = subparsers.add_parser("job")
    subparser.add_argument("experiment_id", type=str)
    subparser.add_argument("timestamp", type=str)
    subparser.add_argument("job_id", type=str)
    subparser.add_argument("--absolute", action="store_true")

    subparser = subparsers.add_parser("task")
    subparser.add_argument("experiment_id", type=str)
    subparser.add_argument("task_id", type=str)
    subparser.add_argument("--absolute", action="store_true")

    return parser.parse_args()


def make_path(args):
    if args.command == "experiment":
        return make_experiment_path(args.experiment_id, absolute=args.absolute)

    if args.command == "job":
        return make_job_path(
            args.experiment_id, args.timestamp, args.job_id, absolute=args.absolute
        )

    if args.command == "task":
        return make_task_path(args.experiment_id, args.task_id, absolute=args.absolute)

    raise ValueError(f"Unknown command: {args.command}")


def main():
    args = parse_args()
    path = make_path(args)
    print(path)


if __name__ == "__main__":
    main()
