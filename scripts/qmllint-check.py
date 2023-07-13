#!/usr/bin/env python
""" Run qmllint
"""

import argparse
import sys
import os
import subprocess
import json

# QML file extensions
qml_extensions = ["qml", "ui.qml"]

# Exclude directories from linting
exclude_dirs = ["build", "out"]

class ReturnCode:
    SUCCESS = 0
    ERROR = 1

def parse_arguments():
    parser = argparse.ArgumentParser(description="Run qmllint")
    parser.add_argument(
        '--executable',
        metavar='EXECUTABLE',
        help='path to the qmllint executable',
        default='qmllint')
    parser.add_argument(
        '--root-path',
        metavar='ROOT_PATH',
        default='.',
        help='Root path for linting')
    parser.add_argument(
        '-o',
        metavar='OUTPUT',
        default='qmllint-report.json',
        help='Output file (JSON)')

    return parser.parse_args()


def find_qmldir_files(root_path):

    qmldir_name = "qmldir"
    out = []

    if os.path.isdir(root_path):
        if os.path.basename(root_path) in exclude_dirs:
            return out
        for dirpath, dirs, fnames in os.walk(root_path):
            dirs[:] = list(filter(lambda x: not x in exclude_dirs, dirs))
            fpaths = [os.path.join(dirpath, fname) for fname in fnames]
            for f in fpaths:
                if os.path.basename(f) == qmldir_name:
                    out.append(f)
    else:
        if os.path.basename(root_path) == qmldir_name:
            out.append(root_path)

    return out


def find_qml_files(root_path):

    out = []

    if os.path.isdir(root_path):
        for dirpath, dirs, fnames in os.walk(root_path):
            dirs[:] = list(filter(lambda x: not x in exclude_dirs, dirs))
            fpaths = [os.path.join(dirpath, fname) for fname in fnames]
            for f in fpaths:
                ext = os.path.splitext(f)[1][1:]
                if ext in qml_extensions:
                    out.append(f)
    else:
        ext = os.path.splitext(root_path)[1][1:]
        if ext in qml_extensions:
            out.append(root_path)

    return out


def print_err(message):
    print("error: {}".format(message), file=sys.stderr)


def run_lint(executable, qmldir_files, qml_files):

    command = [executable]

    command.extend(['--json', '-'])

    for qmldir_file in qmldir_files:
        command.extend(['-i', qmldir_file])

    command.extend(qml_files)

    try:
        proc = subprocess.Popen(
            command,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            universal_newlines=True)
    except OSError as exc:
        raise Exception(
            "Command '{}' failed to start: {}".format(
                subprocess.list2cmdline(command), exc
            )
        )


    outs = proc.stdout.read()
    errs = proc.stderr.read()
    proc.wait()

    return outs, errs


def print_warnings(file_name, file_warnings):
    for warning in file_warnings:
        is_error = False
        id_warning = ""
        line = ""
        message = ""
        if "type" in warning:
            is_error = warning["type"] == "warning"
        if "id" in warning:
            id_warning = warning["id"]
        if "line" in warning:
            line = str(warning["line"])
        if "message" in warning:
            message = warning["message"]


        print_type = sys.stdout
        if is_error:
            print_type = sys.stderr

        print("{}:{}:[{}]: {}".format(file_name, line, id_warning, message), file = print_type)


def process_output(outs, errs):

    result = {}

    if errs:
        print("Errors: {}".format(errs), file=sys.stderr)
        return False

    success = False

    try:
        result = json.loads(outs)
        success = True
        if "revision" in result and "files" in result:
            for item in result["files"]:
                if "success" in item and item["success"] == False:
                    success = False
                if isinstance(item.get("warnings"), list) and "filename" in item:
                    print_warnings(item["filename"], item["warnings"])

        else:
            print("Missing keys in output. Out: {}".format(outs))

    # If the string is not a correct json then an error occurred on the stderr
    except json.JSONDecodeError as decode_error:
        print("Error: {}".format(decode_error.msg), file=sys.stderr)

    return success, result

def main():

    args = parse_arguments()

    qmldir_files = find_qmldir_files(args.root_path)
    qml_files = find_qml_files(args.root_path)

    if not qml_files:
        return

    (outs, errs) = run_lint(args.executable, qmldir_files, qml_files)

    retcode = ReturnCode.SUCCESS

    (success, json_result) = process_output(outs, errs)
    if not success:
        retcode = ReturnCode.ERROR
        with open(args.o, "w") as outfile:
            json.dump(json_result, outfile, indent=2)
    else:
        print("Success")

    return retcode


if __name__ == '__main__':
    sys.exit(main())
