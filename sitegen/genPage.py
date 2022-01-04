#!/usr/bin/env python3

import sys

args = { "template": "template.html", "path": "." }
argNames = ["template","path"]

for i in range(len(sys.argv)-1):
  args[argNames[i]] = sys.argv[i+1]

inp = sys.stdin.read().split("\n")
template = open(args["template"],"r").read()
print(template.replace("PATH",args["path"]).replace("TITLE",inp[0]).replace("HEADER",inp[1]).replace("CONTENT","\n".join(inp[2:])))
