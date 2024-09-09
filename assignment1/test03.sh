#!/bin/dash

#####################################################################################
# Written by: Yuet Yat (Xerox) Chan					zid: z5289835
# Date: 10/03/2024
#
#This is a test for pushy-commit
#####################################################################################


#set up path
PATH="$PATH:$(pwd)"

#create temporary environment
temp_dir=$(mktemp -d)

#clean up temporary directory
trap 'rm -rf "$temp_dir"; exit' INT TERM EXIT

cd "$temp_dir" || exit 1


#call pushy-init in a empty directory
pushy-init

echo "created .pushy directory"

#create temp_file_1
echo "created temp_file_1..."
temp_file_1="$(mktemp)"

#write into temp_file_1
cat > temp_file_1 <<EOF
this is temporary file 1
EOF


#add file
pushy-add temp_file_1
echo "adding temp_file_1..."

#test commiting once
output=$(pushy-commit -m 'first commit')
if [ "$output" = "Committed as commit 0" ]
then
	echo "Correct output text commiting first commit"
else
	echo "Wrong output text commiting first commit, your program printed: $output"
fi

#test nothing to commit text
output2=$(pushy-commit -m "first commit")
if [ "$output2" = "nothing to commit" ]
then
	echo "Correct output text when nothing to commit"
else 
	echo "Wrong output text when nothing to commit, your program printed: $output2"
fi

#check commit 0 correctly made in commit directory
if [ -d ".pushy/commits/0" ]
then
	echo "commit 0 in commits directory"
	#check file in commit directory
	if [ -f ".pushy/commits/0/temp_file_1" ]
	then
		echo "temp_file_1 inside commit 0 directory"
		#check correct commit message
		if [ "$(cat .pushy/commits/0/message)" = "first commit" ]
		then
			echo "correct commit message"
		else 
			echo "error: wrong commit message"
		fi
	else
		echo "error: no temp_file_1 in commit 0"
	fi
else
	echo "error: commit 0 not created"
fi

