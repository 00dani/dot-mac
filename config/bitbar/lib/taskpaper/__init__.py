import base64
import inspect
import os.path as p
import sys

PATH = p.dirname(p.abspath(inspect.getfile(inspect.currentframe())))

def count(file, icon='default'):
  project = ''
  items = []
  with open(p.expanduser(file)) as f:
    for line in f:
      if project.lower() == 'archive': break
      line = line.strip()
      if line.endswith(':'):
        project = line[:-1]
      elif line.startswith('- ') and '@done' not in line:
        items.append('%s (%s)' % (line[2:], project))

  if not items: return

  with open(p.join(PATH, icon + '.png')) as img:
    icon = base64.b64encode(img.read())

  print("%d | templateImage='%s'" % (len(items), icon))
  print('---')
  print("%s | terminal=false bash=/usr/bin/open param1='%s'" % (file, p.expanduser(file)))
  print('---')
  for item in items: print(item)
