#!/usr/bin/env python3

import sys

def is_bal_word(word):
	letter_count = {}
	for letter in word.lower():
		letter_count[letter] = letter_count.get(letter, 0) + 1
	return len(set(letter_count.values())) == 1
	
for line in sys.stdin:
	words = line.split()
	equi_words = filter(is_bal_word, words)
	print(' '.join(equi_words))
