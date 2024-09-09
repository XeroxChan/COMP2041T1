#!/bin/dash

###########################################################################################
# Written by: Yuet Yat (Xerox) Chan					zid: z5289835
# Date: 10/03/2024

#This is a test for pushy-log
###########################################################################################

#set up path
PATH="$PATH:$(pwd)"

#create temporary environment
temp_dir=$(mktemp -d)

#clean up temporary directory
trap 'rm -rf "$temp_dir"; exit' INT TERM EXIT

cd "$temp_dir" || exit 1

#call pushy-init
pushy-init
echo "created .pushy directory"

#create two temp files
temp_file_1=$(mktemp)
temp_file_2=$(mktemp)

actual_output=$(mktemp)
expected_output=$(mktemp)



echo line 1 > "$temp_file_1"
echo hello world > "$temp_file_2"

#add the two files
pushy-add "$temp_file_1" "$temp_file_2"
echo "adding two files.."
commit=$(pushy-commit -m 'first commit')
echo "$commit"

echo  line 2 >> "$temp_file_1"
echo "modified temp_file_1"
pushy-add "$temp_file_1"
echo "added modified temp_file_1"
pushy-commit -m 'second commit'


cat > "$expected_output" << EOF
1 second commit
0 first commit
EOF


pushy-log > "$actual_output"

if ! diff "$actual_output" "$expected_output" > /dev/null
then
	echo "Something wrong with your pushy-log output"
else
	echo "correct pushy-log output"
fi


