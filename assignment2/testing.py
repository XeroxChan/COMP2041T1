#!/usr/bin/env python3

def plus(line, times):
	times += 1
	return line, times
	
def main():
	times = 0
	line = "hi"
	line, times = plus(line, times)
	print(times)

if __name__ == "__main__":
	main()
