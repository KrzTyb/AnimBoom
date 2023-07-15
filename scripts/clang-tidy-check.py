#!/usr/bin/env python
""" Run clang-tidy
"""

import argparse
import subprocess
import sys

def parse_arguments():
    parser = argparse.ArgumentParser(description="Run clang-tidy")
    parser.add_argument(
        '--executable',
        metavar='EXECUTABLE',
        help='path to the run-clang-tidy tool',
        default='run-clang-tidy')
    parser.add_argument(
        '--database',
        metavar='DATABASE',
        help='path to the compile_commands.json dir',
        default='.')
    parser.add_argument(
        '-e',
        '--exclude',
        metavar='EXCLUDE',
        help='Exclude directory',
        action='append',
        default=[])
    parser.add_argument(
        '-j',
        metavar='N',
        type=int,
        default=0,
        help='run N jobs in parallel'
        ' (default number of cpus + 1)')
    parser.add_argument(
        '-o',
        metavar='OUTPUT',
        default='clang-tidy.yaml',
        help='Output file (YAML)')

    return parser.parse_args()

def main():

    args = parse_arguments()

    pattern = r"^(?!.*[/\\]({})[/\\]).*$".format('|'.join(args.exclude))

    command = [args.executable]

    command.extend(['-p', args.database])
    command.extend(['-j', str(args.j)])
    command.extend(['-export-fixes', args.o, pattern])

    try:
        proc = subprocess.Popen(
            command,
            stdout=sys.stdout,
            stderr=sys.stderr,
            universal_newlines=True)
    except OSError as exc:
        raise Exception(
            "Command '{}' failed to start: {}".format(
                subprocess.list2cmdline(command), exc
            )
        )
    return proc.wait()

if __name__ == '__main__':
    sys.exit(main())
