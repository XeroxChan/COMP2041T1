#! /bin/dash

#####################################################################################################################
# Written by: Yuet Yat (Xerox) Chan					zid: z5289835
# Date: 19/04/2024
#
#test03.sh
#testing 'd' command
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
# pure delete command 
#
#===============================================================================

seq 1 5 | eddy.py 'd' > "$actual_output"
seq 1 5 | 2041 eddy 'd' > "$expected_output"

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'seq 1 5 | ./eddy.py 'd'' test"
    exit 1
else
    echo "Passed 'seq 1 5 | ./eddy.py 'd'' test"
fi

#===============================================================================
#
# number delete command 
#
#===============================================================================

seq 1 5 | eddy.py '4d' > "$actual_output"
seq 1 5 | 2041 eddy '4d' > "$expected_output"

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'seq 1 5 | ./eddy.py '4d'' test"
    exit 1
else
    echo "Passed 'seq 1 5 | ./eddy.py '4d'' test"
fi

#===============================================================================
#
# regex delete command 
#
#===============================================================================

seq 1 100 | eddy.py '/.{2}/d' > "$actual_output"
seq 1 100 | 2041 eddy '/.{2}/d' > "$expected_output"

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'seq 1 100 | ./eddy.py '/.{2}/d'' test"
    exit 1
else
    echo "Passed 'seq 1 100 | ./eddy.py '/.{2}/d'' test"
fi


#===============================================================================
#
# delete out of range command 
#
#===============================================================================

seq 1 100 | eddy.py '101d' > "$actual_output"
seq 1 100 | 2041 eddy '101d' > "$expected_output"

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'seq 1 100 | ./eddy.py '101d'' test"
    exit 1
else
    echo "Passed 'seq 1 100 | ./eddy.py '101d'' test"
fi

#===============================================================================
#
# regex address delete command 
#
#===============================================================================
seq 1 200 | eddy.py '/2$/,/8$/d' > "$actual_output"
seq 1 200 | 2041 eddy '/2$/,/8$/d' > "$expected_output"

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'seq 1 100 | ./eddy.py '/2$/,/8$/d'' test"
    exit 1
else
    echo "Passed 'seq 1 100 | ./eddy.py '/2$/,/8$/d' test"
fi
