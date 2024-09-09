#!/bin/dash

###########################################################################################
# Written by: Yuet Yat (Xerox) Chan					zid: z5289835
# Date: 10/03/2024

#This is a test for pushy-show
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

echo line 1 > a
echo hello world > b

#add the two files
pushy-add a b
echo "adding a b"
commit=$(pushy-commit -m 'first commit')
echo "$commit"
echo  line 2 >> a
echo "modified a"
pushy-add a
echo "added modified a"
pushy-commit -m 'second commit'

pushy-log
echo line 3 >> a
pushy-add a
echo line 4 >> a

if [ "$(pushy-show 0:a)" = "line 1" ]
then
	echo "pushy-show 0:a working fine"
else
	echo "something wrong"
fi

pushy-show 1:a > actual_output1

cat > expected_output1 << EOF
line 1
line 2
EOF

if ! diff "expected_output1" "actual_output1"
then
	echo "wrong"
else
	echo "pushy-show 1:a working fine"
fi

pushy-show :a > actual_output2

cat > expected_output2 << EOF
line 1
line 2
line 3
EOF

if ! diff "expected_output2" "actual_output2"
then
	echo "wrong"
else
	echo "pushy-show :a working fine"
fi

