#!/usr/bin/env python
# SPDX-License-Identifier: GPL-3.0-only
# Copyright (C) 2023 Krzysztof Tyburski
"""Script to run qmlformat

NOTE: Based on https://github.com/Sarcasm/run-clang-format, which is
licensed under the MIT license (Copyright (c) 2017 Guillaume Papin).
"""

import argparse
import sys

from helpers import *


QML_EXTENSIONS = 'qml,ui.qml'

def main():
    config = Config()
    
    parser = argparse.ArgumentParser(description=__doc__)
    
    add_standard_arguments(parser)
    
    parser.add_argument(
        '--executable',
        metavar='EXECUTABLE',
        help='path to the qmlformat executable',
        default='qmlformat')
    
    config.args = parser.parse_args()
    config.parser = parser
    
    config_signal_handling()
    
    config.files = list_files(
        config.args.files,
        recursive=config.args.recursive,
        exclude=config.args.exclude,
        extensions=QML_EXTENSIONS.split(','))
    
    config.configure()

    
    version_invocation = [config.args.executable, str("--version")]
    
    if verify_command_binary(config, version_invocation) != ExitStatus.SUCCESS:
        return ExitStatus.TROUBLE

    if not config.files:
        return

    (pool, it) = run_tool(config, run_qmlformat_diff_wrapper)

    return check_results(config, pool, it)

if __name__ == '__main__':
    sys.exit(main())
