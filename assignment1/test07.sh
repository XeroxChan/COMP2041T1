#!/bin/dash

#####################################################################################
# Written by: Yuet Yat (Xerox) Chan					zid: z5289835
# Date: 10/03/2024
#
#This is a test for pushy-rm
#It test the correct error output when usage is wrong
#####################################################################################

#set up path
PATH="$PATH:$(pwd)"

#create temporary environment
temp_dir=$(mktemp -d)

#clean up temporary directory
trap 'rm -rf "$temp_dir"; exit' INT TERM EXIT

cd "$temp_dir" || exit 1


#call pushy-init in a empty directory
pushy-init > /dev/null

touch a b c d e

output=$(pushy-rm -w) > /dev/null

if [ "$output" = 'usage: pushy-rm [--force] [--cached] <filenames>' ]
then
	echo "Correct error output"
else
	echo "Wrong error output"
fi
