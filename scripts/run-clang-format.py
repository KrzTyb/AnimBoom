#!/usr/bin/env python
"""A wrapper script around clang-format, suitable for linting multiple files
and to use for continuous integration.

This is an alternative API for the clang-format command line.
It runs over multiple files and directories in parallel.
A diff output is produced and a sensible exit code is returned.

NOTE: Pulled and modified from https://github.com/Sarcasm/run-clang-format, which is
licensed under the MIT license (Copyright (c) 2017 Guillaume Papin).

"""

import argparse
import sys

from helpers import *


DEFAULT_EXTENSIONS = 'c,h,C,H,cpp,hpp,cc,hh,c++,h++,cxx,hxx'
DEFAULT_CLANG_FORMAT_IGNORE = '.clang-format-ignore'

def main():
    config = Config()

    parser = argparse.ArgumentParser(description=__doc__)
    add_standard_arguments(parser)
    parser.add_argument(
        '--clang-format-executable',
        metavar='EXECUTABLE',
        help='path to the clang-format executable',
        default='clang-format')
    parser.add_argument(
        '--extensions',
        help='comma separated list of file extensions (default: {})'.format(
            DEFAULT_EXTENSIONS),
        default=DEFAULT_EXTENSIONS)
    parser.add_argument(
        '-d',
        '--dry-run',
        action='store_true',
        help='just print the list of files')
    parser.add_argument(
        '--style',
        help='formatting style to apply (LLVM, Google, Chromium, Mozilla, WebKit)')

    config.args = parser.parse_args()
    config.parser = parser

    config_signal_handling()

    excludes = excludes_from_file(DEFAULT_CLANG_FORMAT_IGNORE)
    excludes.extend(config.args.exclude)

    config.files = list_files(
        config.args.files,
        recursive=config.args.recursive,
        exclude=excludes,
        extensions=config.args.extensions.split(','))

    config.configure()

    version_invocation = [config.args.clang_format_executable, str("--version")]

    if verify_command_binary(config, version_invocation) != ExitStatus.SUCCESS:
        return ExitStatus.TROUBLE

    if not config.files:
        return

    (pool, it) = run_tool(config, run_clang_format_diff_wrapper)

    return check_results(config, pool, it)


if __name__ == '__main__':
    sys.exit(main())
