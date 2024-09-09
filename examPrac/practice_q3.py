#!/usr/bin/env python3

import sys
import re

pattern = r"M$"

input = []

for line in sys.stdin:
	line = line.rstrip()
	if re.search(pattern, line):
		splitted_lines = line.split("|")
		name = splitted_lines[2]
		splitted_name = name.split(",")
		surname = splitted_name[0]
		if surname not in input:
			input.append(surname)
			
for line in sorted(input):
	print(line)
