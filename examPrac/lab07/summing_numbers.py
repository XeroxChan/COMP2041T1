#!/usr/bin/env python3

import sys
import re

pattern = re.compile(r'\d+')
total = 0

with open(sys.argv[1], "r") as stream:
	for line in stream:
		numbers = pattern.findall(line)
		total += sum(map(int, numbers))
	print(total)
