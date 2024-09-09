#!/bin/dash

#####################################################################################
# Written by: Yuet Yat (Xerox) Chan					zid: z5289835
# Date: 10/03/2024
#
#This is a test for pushy-commit -a flag
#It shows that even updated files are not added before commit it will add the files 
#and commit them instead of saying nothing to commit
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
pushy-add a b c d e
pushy-commit -m 'first commit' > /dev/null

echo hello >a
echo hello >b
output=$(pushy-commit -a -m 'second commit')

if [ "$output" = "Committed as commit 1" ]
then
	echo "Correct output"
else
	echo "Wrong output"
fi


