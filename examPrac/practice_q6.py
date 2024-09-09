#!/usr/bin/env python3
import sys

with open(sys.argv[1], "r") as f1:
	f1_lines = [line.rstrip('\n') for line in f1]
		

with open(sys.argv[2], "r") as f2:
	f2_lines = [line.rstrip('\n') for line in f2]

reverse_f2 = [ line for line in reversed(f2_lines)]

if len(f1_lines) != len(reverse_f2):
	print(f"Not mirrored: different number of lines: {len(f1_lines)} versus {len(f2_lines)}")
elif f1_lines == reverse_f2:
	print("Mirrored")
else:
	for i in range(len(f1_lines)):
		if f1_lines[i] != reverse_f2[i]:
			print(f"Not mirrored: line {i+1} different")
			break
