#!/bin/dash

#####################################################################################
# Written by: Yuet Yat (Xerox) Chan					zid: z5289835
# Date: 10/03/2024
#
#This is a test for pushy-add
#####################################################################################


PATH="$PATH:$(pwd)"

#create temporary directory
temp_dir=$(mktemp -d)

#clean up temporary directory
trap 'rm -rf "$temp_dir"; exit' INT TERM EXIT

cd "$temp_dir" || exit 1

#call pushy-init in a empty directory
output1=$(pushy-init)

echo "created .pushy directory"

#try adding non-existing file
echo "try adding non-existing file..."
output=$(pushy-add temp_file_1)
if [ "$output" = "pushy-add: error: can not open 'temp_file_1'" ]
then
	echo "You have the correct error output"
else
	echo "You do not have the correct error output"
fi

#create temp_file_1
echo "created temp_file_1..."
temp_file_1="$(mktemp)"

#write into temp_file_1
cat > temp_file_1 <<EOF
this is temporary file 1
EOF

#add temp_file_1
echo "adding temp_file_1..."
pushy-add temp_file_1

#check if temp_file_1 exist in .pushy/index
if [ -f "temp_file_1" ]
then
	echo "temp_file_1 added into .pushy/index"
else
	echo "Did not add file to .pushy/index"
fi

