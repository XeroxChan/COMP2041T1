#! /bin/dash

#####################################################################################################################
# Written by: Yuet Yat (Xerox) Chan					zid: z5289835
# Date: 19/04/2024
#
#test01.sh
#testing 'q' command
#
#
#####################################################################################################################


PATH="$PATH:$(pwd)"

# Create a temporary directory for the test.
test_dir="$(mktemp -d)"
cd "$test_dir" || exit 1

# Create some files to hold output.
expected_output="$(mktemp)"
actual_output="$(mktemp)"


# Remove the temporary directory when the test is done.

trap 'rm "$expected_output" "$actual_output" -rf "$test_dir"' INT HUP QUIT TERM EXIT


#===============================================================================
#
# pure quit command 
#
#===============================================================================

seq -10 -1 | eddy.py 'q' > "$actual_output"
seq -10 -1 | 2041 eddy 'q' > "$expected_output"



if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'seq -10 -1 | ./eddy.py 'q'' test"
    exit 1
else
    echo "Passed 'seq -10 -1 | ./eddy.py 'q'' test"
fi

#===============================================================================
#
# simple quit command 
#
#===============================================================================

seq -10 -1 | eddy.py '4q' > "$actual_output"
seq -10 -1 | 2041 eddy '4q' > "$expected_output"


if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'seq -10 -1 | ./eddy.py '4q'' test"
    exit 1
else
    echo "Passed 'seq -10 -1 | ./eddy.py '4q'' test"
fi

#===============================================================================
#
# quit command with regular expression
#
#===============================================================================

seq 10 15 | eddy.py '/.1/q' > "$actual_output"
seq 10 15 | 2041 eddy '/.1/q' > "$expected_output"

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'seq 10 15 | ./eddy.py '/.1/q'' test"
    exit 1
else
    echo "Passed 'seq 10 15 | ./eddy.py  '/.1/q'' test"
fi

#===============================================================================
#
# quit command with infinite inputs
#
#===============================================================================

yes | eddy.py '3q' > "$actual_output"
yes | 2041 eddy '3q' > "$expected_output"

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'yes | ./eddy.py  '3q'' test"
    exit 1
else
    echo "Passed 'yes | ./eddy.py  '3q'' test"
fi
