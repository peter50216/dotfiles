import os
import sys


def DirectoryOfThisScript():
  return os.path.dirname(os.path.abspath(__file__))


# These are the compilation flags that will be used in case there's no
# compilation database set (by default, one is not set).
# CHANGE THIS LIST OF FLAGS. YES, THIS IS THE DROID YOU HAVE BEEN LOOKING FOR.
flags = [
    '-Wall',
    '-Wextra',
    # THIS IS IMPORTANT! Without a "-std=<something>" flag, clang won't know which
    # language to use when compiling headers. So it will guess. Badly. So C++
    # headers will be compiled as C headers. You don't want that so ALWAYS specify
    # a "-std=<something>".
    # For a C project, you would set this to something like 'c99' instead of
    # 'c++11'.
    '-std=c++17',
    # ...and the same thing goes for the magic -x option which specifies the
    # language that the files to be compiled are written in. This is mostly
    # relevant for c++ headers.
    # For a C project, you would set this to 'c' instead of 'c++'.
    '-x',
    'c++',
    '-DYCM',
]
if os.path.exists(
    os.path.join(DirectoryOfThisScript(), 'ycm_extra_conf_local.py')):
  sys.path.append(DirectoryOfThisScript())
  import ycm_extra_conf_local
  flags += ycm_extra_conf_local.flags


def MakeRelativePathsInFlagsAbsolute(flags, working_directory):
  if not working_directory:
    return flags
  new_flags = []
  make_next_absolute = False
  path_flags = ['-isystem', '-I', '-iquote', '--sysroot=']
  for flag in flags:
    new_flag = flag

    if make_next_absolute:
      make_next_absolute = False
      if not flag.startswith('/'):
        new_flag = os.path.join(working_directory, flag)

    for path_flag in path_flags:
      if flag == path_flag:
        make_next_absolute = True
        break

      if flag.startswith(path_flag):
        path = flag[len(path_flag):]
        new_flag = path_flag + os.path.join(working_directory, path)
        break

    if new_flag:
      new_flags.append(new_flag)
  return new_flags


def FlagsForFile(filename):
  relative_to = DirectoryOfThisScript()
  final_flags = MakeRelativePathsInFlagsAbsolute(flags, relative_to)

  return {'flags': final_flags, 'do_cache': True}
