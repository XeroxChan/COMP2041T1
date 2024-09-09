#!/usr/bin/env python3

import sys
import re

word_count = 0
for line in sys.stdin:
	line_words = re.findall(r'[A-Za-z]+', line)
	line_word_count = len(line_words)
	word_count += line_word_count

print(f'{word_count} words')
