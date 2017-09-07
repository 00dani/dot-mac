#!/usr/bin/python
import sys
from os.path import abspath, dirname, join

LIB = join(dirname(dirname(abspath(sys.argv[0]))), 'lib')
sys.path.insert(0, LIB)

import taskpaper
taskpaper.count('~/Dropbox/Tasks/Personal.taskpaper')
