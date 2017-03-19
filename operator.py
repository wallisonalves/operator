#!/usr/local/bin/python

from os import system
from sys import argv
cl = argv[1]

liste = open('/usr/local/share/operator/editor').read()

if "sudo" in argv[1:]:
    print("Can't use sudo with operator")
elif ">" in argv[1:]:
    print("Can't use > with operator")
elif cl in liste:
    print(("Can't use %s with operator!" % argv[1]))
else:
    cmd = ''
    for line in argv[1:]:
        cmd += line + " "
    system(cmd)