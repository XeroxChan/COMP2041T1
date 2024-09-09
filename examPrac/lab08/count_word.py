#!/usr/bin/env python3

import sys
import re

target = sys.argv[1]
word_count = 0
for line in sys.stdin:
	line = line.lower()
	line_words = re.findall(r'[A-Za-z]+', line)
	for word in line_words:
		if word == target:
			word_count += 1

print(f'{word_count} words')
