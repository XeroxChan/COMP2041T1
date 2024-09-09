#!/bin/dash

#####################################################################################
# Written by: Yuet Yat (Xerox) Chan					zid: z5289835
# Date: 10/03/2024
#
#This is a test for pushy-init
#It test if the output of my pushy-init matches the expected
#####################################################################################

#set up path
PATH="$PATH:$(pwd)"


#create temporary environment
temp_dir=$(mktemp -d)

#clean up temporary directory
trap 'rm -rf "$temp_dir"; exit' INT TERM EXIT

cd "$temp_dir" || exit 1

#call pushy-init in a empty directory
output1=$(pushy-init)

echo "First pushy-init call..."

#compare the output and check if there is a .pushy directory
if [ "$output1" = "Initialized empty pushy repository in .pushy" ]
then
	echo "Program successfully printed the expected output"
else
	echo "Your program printed this: $output1"
fi


echo "Second pushy-init call..."

#call pushy-init when .pushy exists
output2=$(pushy-init)

#compare the output with the expected error output
if [ "$output2" = "pushy-init: error: .pushy already exists" ]
then
	echo "Correct error texts"
else
	echo "Your program printed this: $output2"
fi

