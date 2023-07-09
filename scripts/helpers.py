#!/usr/bin/env python
"""Helper functions for linters and validations

NOTE: Based on https://github.com/Sarcasm/run-clang-format, which is
licensed under the MIT license (Copyright (c) 2017 Guillaume Papin).

"""

from __future__ import print_function, unicode_literals

import codecs
import difflib
import fnmatch
import io
import errno
import os
import multiprocessing
import subprocess
import sys
import signal
import traceback

from functools import partial

try:
    from subprocess import DEVNULL  # py3k
except ImportError:
    DEVNULL = open(os.devnull, "wb")

class ExitStatus:
    SUCCESS = 0
    DIFF = 1
    TROUBLE = 2
    
class Config:
    args = None
    parser = None
    colored_stderr = False
    njobs = 0
    files = []
    
    def configure(self):
        self.colored_stdout = False
        self.colored_stderr = False
        if self.args.color == 'always':
            self.colored_stdout = True
            self.colored_stderr = True
        elif self.args.color == 'auto':
            self.colored_stdout = sys.stdout.isatty()
            self.colored_stderr = sys.stderr.isatty()
        
        self.njobs = self.args.j
        if self.njobs == 0:
            self.njobs = multiprocessing.cpu_count() + 1
        self.njobs = min(len(self.files), self.njobs)

def excludes_from_file(ignore_file):
    excludes = []
    try:
        with io.open(ignore_file, 'r', encoding='utf-8') as f:
            for line in f:
                if line.startswith('#'):
                    # ignore comments
                    continue
                pattern = line.rstrip()
                if not pattern:
                    # allow empty lines
                    continue
                excludes.append(pattern)
    except EnvironmentError as e:
        if e.errno != errno.ENOENT:
            raise
    return excludes;

def list_files(files, recursive=False, extensions=None, exclude=None):
    if extensions is None:
        extensions = []
    if exclude is None:
        exclude = []

    out = []
    for file in files:
        if recursive and os.path.isdir(file):
            for dirpath, dnames, fnames in os.walk(file):
                fpaths = [os.path.join(dirpath, fname) for fname in fnames]
                for pattern in exclude:
                    # os.walk() supports trimming down the dnames list
                    # by modifying it in-place,
                    # to avoid unnecessary directory listings.
                    dnames[:] = [
                        x for x in dnames
                        if
                        not fnmatch.fnmatch(os.path.join(dirpath, x), pattern)
                    ]
                    fpaths = [
                        x for x in fpaths if not fnmatch.fnmatch(x, pattern)
                    ]
                for f in fpaths:
                    ext = os.path.splitext(f)[1][1:]
                    if ext in extensions:
                        out.append(f)
        else:
            out.append(file)
    return out


def make_diff(file, original, reformatted):
    return list(
        difflib.unified_diff(
            original,
            reformatted,
            fromfile='{}\t(original)'.format(file),
            tofile='{}\t(reformatted)'.format(file),
            n=3))


class DiffError(Exception):
    def __init__(self, message, errs=None):
        super(DiffError, self).__init__(message)
        self.errs = errs or []


class UnexpectedError(Exception):
    def __init__(self, message, exc=None):
        super(UnexpectedError, self).__init__(message)
        self.formatted_traceback = traceback.format_exc()
        self.exc = exc


def run_clang_format_diff_wrapper(args, file):

    command = [args.clang_format_executable]
    
    if args.in_place:
        command.extend(['-i'])
        
    if args.style:
        command.extend(['--style', args.style])
    
    command.extend([file])

    if args.dry_run:
        print(" ".join(command))
        return [], []

    try:
        ret = run_format_diff(args, file, command)
        return ret
    except DiffError:
        raise
    except Exception as e:
        raise UnexpectedError('{}: {}: {}'.format(file, e.__class__.__name__,
                                                  e), e)


def run_qmlformat_diff_wrapper(args, file):
    
    command = [args.executable, '-n']
    
    if args.in_place:
        command.extend(['-i'])
    
    command.extend([file])
    
    try:
        ret = run_format_diff(args, file, command)
        return ret
    except DiffError:
        raise
    except Exception as e:
        raise UnexpectedError('{}: {}: {}'.format(file, e.__class__.__name__,
                                                  e), e)

def run_format_diff(args, file, command):
    try:
        with io.open(file, 'r', encoding='utf-8') as f:
            original = f.readlines()
    except IOError as exc:
        raise DiffError(str(exc))

    try:
        proc = subprocess.Popen(
            command,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            universal_newlines=True)
    except OSError as exc:
        raise DiffError(
            "Command '{}' failed to start: {}".format(
                subprocess.list2cmdline(command), exc
            )
        )
    proc_stdout = proc.stdout
    proc_stderr = proc.stderr
    # hopefully the stderr pipe won't get full and block the process
    outs = list(proc_stdout.readlines())
    errs = list(proc_stderr.readlines())
    proc.wait()
    if proc.returncode:
        raise DiffError(
            "Command '{}' returned non-zero exit status {}".format(
                subprocess.list2cmdline(command), proc.returncode
            ),
            errs,
        )
    if args.in_place:
        return [], errs
    return make_diff(file, original, outs), errs


def bold_red(s):
    return '\x1b[1m\x1b[31m' + s + '\x1b[0m'


def colorize(diff_lines):
    def bold(s):
        return '\x1b[1m' + s + '\x1b[0m'

    def cyan(s):
        return '\x1b[36m' + s + '\x1b[0m'

    def green(s):
        return '\x1b[32m' + s + '\x1b[0m'

    def red(s):
        return '\x1b[31m' + s + '\x1b[0m'

    for line in diff_lines:
        if line[:4] in ['--- ', '+++ ']:
            yield bold(line)
        elif line.startswith('@@ '):
            yield cyan(line)
        elif line.startswith('+'):
            yield green(line)
        elif line.startswith('-'):
            yield red(line)
        else:
            yield line


def print_diff(diff_lines, use_color):
    if use_color:
        diff_lines = colorize(diff_lines)
    sys.stdout.writelines(diff_lines)


def print_trouble(prog, message, use_colors):
    error_text = 'error:'
    if use_colors:
        error_text = bold_red(error_text)
    print("{}: {} {}".format(prog, error_text, message), file=sys.stderr)


def add_standard_arguments(parser):
    parser.add_argument(
        '-r',
        '--recursive',
        action='store_true',
        help='run recursively over directories')
    parser.add_argument(
        '-i',
        '--in-place',
        action='store_true',
        help='format file instead of printing differences')
    parser.add_argument(
        '-q',
        '--quiet',
        action='store_true',
        help="disable output, useful for the exit code")
    parser.add_argument(
        '-e',
        '--exclude',
        metavar='PATTERN',
        action='append',
        default=[],
        help='exclude paths matching the given glob-like pattern(s)'
        ' from recursive search')
    parser.add_argument(
        '--color',
        default='auto',
        choices=['auto', 'always', 'never'],
        help='show colored diff (default: auto)')
    parser.add_argument(
        '-j',
        metavar='N',
        type=int,
        default=0,
        help='run N jobs in parallel'
        ' (default number of cpus + 1)')
    parser.add_argument('files', metavar='file', nargs='+')
    

def config_signal_handling():
    # use default signal handling, like diff return SIGINT value on ^C
    # https://bugs.python.org/issue14229#msg156446
    signal.signal(signal.SIGINT, signal.SIG_DFL)
    try:
        signal.SIGPIPE
    except AttributeError:
        # compatibility, SIGPIPE does not exist on Windows
        pass
    else:
        signal.signal(signal.SIGPIPE, signal.SIG_DFL)

def verify_command_binary(config, version_invocation):
    assert config.parser, "Missing parser"
    
    try:
        subprocess.check_call(version_invocation, stdout=DEVNULL)
    except subprocess.CalledProcessError as e:
        print_trouble(config.parser.prog, str(e), use_colors=config.colored_stderr)
        return ExitStatus.TROUBLE
    except OSError as e:
        print_trouble(
            config.parser.prog,
            "Command '{}' failed to start: {}".format(
                subprocess.list2cmdline(version_invocation), e
            ),
            use_colors=config.colored_stderr,
        )
        return ExitStatus.TROUBLE
    return ExitStatus.SUCCESS


def run_tool(config, function):
    if config.njobs == 1:
        # execute directly instead of in a pool,
        # less overhead, simpler stacktraces
        it = (function(config.args, file) for file in config.files)
        pool = None
    else:
        pool = multiprocessing.Pool(config.njobs)
        it = pool.imap_unordered(
            partial(function, config.args), config.files)
        pool.close()
    
    return (pool, it)

def check_results(config, pool, results):
    
    retcode = ExitStatus.SUCCESS
    while True:
        try:
            outs, errs = next(results)
        except StopIteration:
            break
        except DiffError as e:
            print_trouble(config.parser.prog, str(e), use_colors=config.colored_stderr)
            retcode = ExitStatus.TROUBLE
            sys.stderr.writelines(e.errs)
        except UnexpectedError as e:
            print_trouble(config.parser.prog, str(e), use_colors=config.colored_stderr)
            sys.stderr.write(e.formatted_traceback)
            retcode = ExitStatus.TROUBLE
            # stop at the first unexpected error,
            # something could be very wrong,
            # don't process all files unnecessarily
            if pool:
                pool.terminate()
            break
        else:
            sys.stderr.writelines(errs)
            if outs == []:
                continue
            print_diff(outs, use_color=config.colored_stdout)
            if retcode == ExitStatus.SUCCESS:
                retcode = ExitStatus.DIFF
    if pool:
        pool.join()
    return retcode
