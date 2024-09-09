#! /usr/bin/env python3


#####################################################################################################################
# Written by: Yuet Yat (Xerox) Chan					zid: z5289835
# Date: 19/04/2024
#
# Usage: ./eddy.py [-nf] [REGEX]
#
# eddy.py is a python version of a simple version of sed which involves quit, print, delete and substitute functions
#
#####################################################################################################################


import sys
import re
import argparse

#modified version of argparse to silence its own error message
class SilentArgumentParser(argparse.ArgumentParser):
	def error(self, message):
		#error message when no command
        	raise SystemExit('usage = eddy [-h] [-n] [-f] [-i] command [command ...]')

# Function to parse command-line arguments
def parse_arguments():
	#using customised argparser
	parser = SilentArgumentParser()
	#flags
	parser.add_argument('-n', action = 'store_true')
	parser.add_argument('-f', action = 'store_true')
	#commands
	parser.add_argument('command', nargs='+', type = str)
	try:
		args = parser.parse_args()
		return args.n, args.f, args.command
	except SystemExit as e:
		#print error meesage
		print(e)
		exit(1)

# Function to parse multiple lines of command seperated by ; or \n
def parse_commands(commands):
	parsed_commands = []
	for command in commands:
		#if ; or \n is present, split them into subparts
		if re.search(r'[;\n]', command) != None:
			splitted_commands = re.split(r'[;\n]+', command)
			#append the subparts to the parsed_commands after checking it is not an empty string and removing white spaces
			for cmd in splitted_commands:
				if cmd != '':
					cmd = cmd.rstrip()
					parsed_commands.append(cmd)
		else:
			parsed_commands.append(command)
	return parsed_commands

def get_files(files):
	result = []
	for filename in files:
		result.append(filename)
	return result

#Function to get commands from files
def get_content(files):
	content = []
	for file in files:
		with open(file, "r") as f:
			for line in f:
				content.append(line.strip())
	content.append('EOF')
	return content

#Function to obtain regex between '/'
def process_command(command):
	split_command = command.split('/')
	return split_command
	
#quit command
def q(n_option, command, result, times):
	processed_command = process_command(command)
	#read content from sys.stdin
	if times == 0:
		times += 1
		#pure quit
		if len(command) == 1:
			for line in sys.stdin:
				result += line
				break
		#number quit
		elif len(processed_command) == 1:
			i = 0
			quit_length = command.strip('q')
			for line in sys.stdin:
				if i < int(quit_length):
					if n_option == False:
						result += line
				else:
					break
				i += 1
		#regex quit
		else:
			#print(processed_command)
			for line in sys.stdin:
				if re.search(fr'{processed_command[1]}', line):
					if n_option == False:
						result += line
						break
				else:
					if n_option == False:
						result += line
	#read content from result
	else:
		#number quit
		if len(processed_command) == 1:
			i = 0
			quit_length = command.strip('q')
			for line in result:
				if i < int(quit_length):
					continue
				else:
					break
				i += 1
	return result, times
	
#print command
def p(n_option, command, result, times):
	processed_command = process_command(command)
	if times == 0:
		times += 1
		#pure 'p'
		if len(command) == 1:
			for line in sys.stdin:
				if n_option == False:
					result += line
					result += line
				if n_option == True:
					result += line
		#number print
		elif len(processed_command) == 1:
			print_target = int(command.strip('p'))
			i = 1
			for line in sys.stdin:
				if n_option == False:
					result += line
					if i == print_target:
						result += line
				if n_option == True:
					if i == print_target:
						result += line
				i += 1
		#regex print e.g /^7/p		
		elif len(processed_command) == 3:
			for line in sys.stdin:
				if re.search(fr'{processed_command[1]}', line):
					result += line
					if n_option == False:
						result += line
				else:
					if n_option == False:
						result += line
		#regex address print e.g. /2$/,/8$/p
		else:
			if n_option == True:
				keep = []
				start_regex = fr'{processed_command[1]}'
				end_regex = fr'{processed_command[3]}'
				print_mode = False
				for line in sys.stdin:
					#does match starting regex, append to list and turn on print_mode
					if re.search(start_regex, line):
						keep.append(line.rstrip())
						print_mode = True
					#does not match starting regex but in print_mode
					if not re.search(start_regex, line) and print_mode == True:
						keep.append(line.rstrip())
					#match end regex and print mode is on, turn off print mode
					if re.search(end_regex, line) and print_mode == True:
						print_mode = False
					
				result = '\n'.join(keep)
			elif n_option == False:
				keep = []
				start_regex = fr'{processed_command[1]}'
				end_regex = fr'{processed_command[3]}'
				print_mode = False
				for line in sys.stdin:
					keep.append(line.rstrip())
					#does match starting regex, append to list and turn on print_mode
					if re.search(start_regex, line):
						keep.append(line.rstrip())
						print_mode = True
					#does not match starting regex but in print_mode
					if not re.search(start_regex, line) and print_mode == True:
						keep.append(line.rstrip())
					#match end regex and print mode is on, turn off print mode
					if re.search(end_regex, line) and print_mode == True:
						print_mode = False
					
				result = '\n'.join(keep)
	#read from result
	else:
		#number print
		if len(command) == 2:
			print_target = int(command.strip('p'))
			#print(print_target)
			i = 1
			for line in result:
				if n_option == False:
					result += line
					if i == print_target:
						result += line
				if n_option == True:
					if i == print_target:
						result += line
				i += 1
		#regex print		
		else:
			for line in result:
				if re.search(fr'{processed_command[1]}', line):
					result += line
					if n_option == False:
						result += line
				else:
					if n_option == False:
						result += line
		
		
	return result, times
	
def d(n_option, command, result, times):
	processed_command = process_command(command)
	if times == 0:
		times += 1
		#pure 'd'
		if len(command) == 1:
			#add nothing to result
			pass
		#number delete
		elif len(processed_command) == 1:
			delete_target = int(command.strip('d'))
			i = 1
			for line in sys.stdin:
				if n_option == False:
					if i != delete_target:
						result += line
				i += 1
		#simple regex delete e.g. /2/d
		elif len(processed_command) == 3:
			for line in sys.stdin:
				if re.search(fr'{processed_command[1]}', line):
					pass
				else:
					result += line
		#regex address delete e.g. /2$/,/8$/d
		else:
			keep = []
			start_regex = fr'{processed_command[1]}'
			end_regex = fr'{processed_command[3]}'
			delete_mode = False
			for line in sys.stdin:
				#does not match starting regex, append to list
				if not re.search(start_regex, line) and delete_mode == False:
					keep.append(line.rstrip())
				#match starting regex, and is not in delete_mode
				if re.search(start_regex, line) and delete_mode == False:
					delete_mode = True
				#found end regex and delete mode is on, turn off delete mode
				if re.search(end_regex, line) and delete_mode == True:
					delete_mode = False
				
			result = '\n'.join(keep)
	#read from result
	else:
		#pure 'd'
		if len(command) == 1:
			result = ''
		#number delete
		elif len(processed_command) == 1:
			#get the target line
			delete_target = int(command.strip('d'))
			#split the result string with '\n'
			lines = result.split('\n')
			#delete the target and then rejoin the strings
			lines.pop(delete_target - 1)
			result = '\n'.join(lines)			
		#regex delete
		elif len(processed_command) == 3:
			delete_regex = fr'{processed_command[1]}'
			lines = result.split('\n')
			keep = []
			for line in lines:
				if not re.search(delete_regex, line):
					keep.append(line.rstrip())
			result = '\n'.join(keep)
	return result, times

#delimiter would be the first character after the first 's'
def process_sub_commands(command):
	s_index = command.index('s')
	delimiter = int(s_index) + 1
	splitted_command = command.split(command[delimiter])
	return splitted_command

def s(n_option, command, result, times):
	splitted_command = process_sub_commands(command)
	#simple s e.g 's/e//'
	if len(splitted_command) == 4:
		sub_target = fr'{splitted_command[1]}'
		to_sub = fr'{splitted_command[2]}'
		#if there is a address
		sub_line = splitted_command[0].strip('s')
		#read from stdin
		if times == 0:
			if sub_line != '':
				sub_line = int(sub_line)
				i = 1
				for line in sys.stdin:
					if re.search(sub_target, line) and i == sub_line:
						#global
						if splitted_command[-1] == 'g':
							result += re.sub(sub_target, to_sub, line)
						#not global
						else:
							result += re.sub(sub_target, to_sub, line, count = 1)
					else:
						result += line
					i += 1
			elif sub_line == '':
				for line in sys.stdin:
					if re.search(sub_target, line):
						#global
						if splitted_command[-1] == 'g':
							result += re.sub(sub_target, to_sub, line)
						#not global
						else:
							result += re.sub(sub_target, to_sub, line, count = 1)
					else:
						result += line
	#regex sub
	elif len(splitted_command) == 6:
		address = fr'{splitted_command[1]}'
		sub_target = fr'{splitted_command[3]}'
		to_sub = fr'{splitted_command[4]}'
		#read from stdin
		if times == 0:
			for line in sys.stdin:
				#found address and target
				if re.search(address, line) and re.search(sub_target, line):
					#global
					if splitted_command[-1] == 'g':
						result += re.sub(sub_target, to_sub, line)
					else :
						result += re.sub(sub_target, to_sub, line, count = 1)
				else:
					result += line
	#regex address sub
	else:
		start_regex = fr'{splitted_command[1]}'
		end_regex = fr'{splitted_command[3]}'
		sub_target = fr'{splitted_command[5]}'
		to_sub = fr'{splitted_command[6]}'
		keep = []
		sub_mode = False
		#read from stdin
		if times == 0:
			for line in sys.stdin:
				#found start_regex
				if re.search(start_regex, line):
					sub_mode = True
					if re.search(sub_target, line):
						#global
						if splitted_command[-1] == 'g':
							changed_line = re.sub(sub_target, to_sub, line)
							keep.append(changed_line.rstrip())
						else:
							changed_line = re.sub(sub_target, to_sub, line, count = 1)
							keep.append(changed_line.rstrip())
				#does not find start_regex but in sub_mode
				if not re.search(start_regex, line) and sub_mode == True:
					if re.search(sub_target, line):
						#global
						if splitted_command[-1] == 'g':
							changed_line = re.sub(sub_target, to_sub, line)
							keep.append(changed_line.rstrip())
						else:
							changed_line = re.sub(sub_target, to_sub, line, count = 1)
							keep.append(changed_line.rstrip())
								#does not find start_regex but in sub_mode
				if not re.search(start_regex, line) and sub_mode == False:		
					keep.append(line.rstrip())
				#found end_regex
				elif re.search(end_regex, line) and sub_mode == True:
					sub_mode = False
			result = '\n'.join(keep)
	return result, times
	
# Main function to coordinate the parsing and processing
def main():
	#parse arguments
	n_option, f_option, commands = parse_arguments()
	
	#when -f, commands is the filename
	if f_option == True:
		commands_in_file = get_content(commands)
		parsed_commands = parse_commands(commands_in_file)
		
	#parse commands when it is not -f
	if f_option == False:
		parsed_commands = parse_commands(commands)

#	input_from_files = False
	
	#input from file
#	if len(commands) > 1:
#		input_from_files = True
#		
#		files = get_files(commands[1:])
#	
#	if input_from_files == True:
#		input_content = get_content(files)
#		if input_content[-1] != 'EOF':
#			input_content.append('EOF')
#	else:
#		input_content = []
		
	#output location
	stream = sys.stdout
	result = ''
	#variable to determine if it is the first eddy run
	times = 0
	#loop through all the commands and do the operation
	for cmd in parsed_commands:
		#print(cmd)
		if re.search(r'q', cmd):
			result, times = q(n_option, cmd, result, times)
			#break
		elif re.search(r'p', cmd):
			result, times = p(n_option, cmd, result, times)
		elif re.search(r'd', cmd):
			result, times = d(n_option, cmd, result, times)
		elif re.search(r's', cmd):
			result, times = s(n_option, cmd, result, times)
		
	#remove last '\n'
	if result != None:
		result = result.rstrip()
		if len(result) == 0:
			print(result, end='')
		else:
			print(result)


if __name__ == '__main__':
	main()
