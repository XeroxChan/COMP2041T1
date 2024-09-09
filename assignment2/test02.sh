#! /bin/dash

#####################################################################################################################
# Written by: Yuet Yat (Xerox) Chan					zid: z5289835
# Date: 19/04/2024
#
#test02.sh
#testing 'p' command
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
# pure print command 
#
#===============================================================================

seq 1 5 | eddy.py 'p' > "$actual_output"
seq 1 5 | 2041 eddy 'p' > "$expected_output"

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'seq 1 5 | ./eddy.py 'p'' test"
    exit 1
else
    echo "Passed 'seq 1 5 | ./eddy.py 'p'' test"
fi

#===============================================================================
#
# number print command 
#
#===============================================================================

seq 1 5 | eddy.py '2p' > "$actual_output"
seq 1 5 | 2041 eddy '2p' > "$expected_output"

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'seq 1 5 | ./eddy.py '2p'' test"
    exit 1
else
    echo "Passed 'seq 1 5 | ./eddy.py '2p'' test"
fi

#===============================================================================
#
# regex print command 
#
#===============================================================================

seq 65 85 | eddy.py '/^7/p' > "$actual_output"
seq 65 85 | 2041 eddy '/^7/p' > "$expected_output"

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'seq 65 85 | ./eddy.py '/^7/p'' test"
    exit 1
else
    echo "Passed 'seq 65 85 | ./eddy.py '/^7/p'' test"
fi



#===============================================================================
#
# print out of range command 
#
#===============================================================================

seq 1 5 | eddy.py '8p' > "$actual_output"
seq 1 5 | 2041 eddy '8p' > "$expected_output"

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'seq 1 5 | ./eddy.py '8p'' test"
    exit 1
else
    echo "Passed 'seq 1 5 | ./eddy.py '8p'' test"
fi

#===============================================================================
#
# print -n 
#
#===============================================================================

seq 1 5 | eddy.py -n '2p' > "$actual_output"
seq 1 5 | 2041 eddy -n '2p' > "$expected_output"

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'seq 1 5 | ./eddy.py -n '2p'' test"
    exit 1
else
    echo "Passed 'seq 1 5 | ./eddy.py -n '2p'' test"
fi

#===============================================================================
#
# regex address print command 
#
#===============================================================================

seq 1 100 | eddy.py '/2$/,/8$/p' > "$actual_output"
seq 1 100 | 2041 eddy '/2$/,/8$/p' > "$expected_output"

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'seq 1 100 | ./eddy.py '/2$/,/8$/p'' test"
    exit 1
else
    echo "Passed 'seq 1 100 | ./eddy.py '/2$/,/8$/p'' test"
fi

#===============================================================================
#
# regex address -n print command 
#
#===============================================================================

seq 1 100 | eddy.py -n '/2$/,/8$/p' > "$actual_output"
seq 1 100 | 2041 eddy -n '/2$/,/8$/p' > "$expected_output"

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'seq 1 100 | ./eddy.py -n '/2$/,/8$/p'' test"
    exit 1
else
    echo "Passed 'seq 1 100 | ./eddy.py -n '/2$/,/8$/p'' test"
fi
