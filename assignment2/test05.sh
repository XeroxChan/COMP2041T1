#! /bin/dash

#####################################################################################################################
# Written by: Yuet Yat (Xerox) Chan					zid: z5289835
# Date: 19/04/2024
#
#test04.sh
#testing -f option
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
# Test -f option for command
#
#===============================================================================

echo 5q > commands.eddy
seq 1 6 | eddy.py -f commands.eddy > "$actual_output"
seq 1 6 | 2041 eddy -f commands.eddy > "$expected_output"

if ! diff "$actual_output" "$expected_output"; then
	echo "Failed 'seq 1 6 | eddy.py -f commands.eddy' test"
	exit 1
else
	echo "Passed seq 1 6 | eddy.py -f commands.eddy' test"
fi
