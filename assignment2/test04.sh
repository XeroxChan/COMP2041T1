#! /bin/dash

#####################################################################################################################
# Written by: Yuet Yat (Xerox) Chan					zid: z5289835
# Date: 19/04/2024
#
#test04.sh
#testing 's' command
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
# simple substitute command 
#
#===============================================================================

seq 1 5 | eddy.py 's/[15]/zzz/' > "$actual_output"
seq 1 5 | 2041 eddy 's/[15]/zzz/' > "$expected_output"

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'seq 1 5 | eddy.py 's/[15]/zzz/''test"
    exit 1
else
    echo "Passed 'seq 1 5 | eddy.py 's/[15]/zzz/''test"
fi

#===============================================================================
#
# global substitute command 
#
#===============================================================================

echo Hello Andrew | eddy.py 's/e//g' > "$actual_output"
echo Hello Andrew | 2041 eddy 's/e//g' > "$expected_output"

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'echo Hello Andrew | eddy.py 's/e//g''test"
    exit 1
else
    echo "Passed 'echo Hello Andrew | eddy.py 's/e//g''test"
fi

#===============================================================================
#
# number address substitute command 
#
#===============================================================================

seq 11 19 | eddy.py '5s/1/2/' > "$actual_output"
seq 11 19 | 2041 eddy '5s/1/2/' > "$expected_output"

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'seq 11 19 | eddy.py '5s/1/2/''test"
    exit 1
else
    echo "Passed 'seq 11 19 | eddy.py '5s/1/2/''test"
fi

#===============================================================================
#
# regex address substitute command 
#
#===============================================================================

seq 100 111 | eddy.py '/1.1/s/1/-/g' > "$actual_output"
seq 100 111 | 2041 eddy '/1.1/s/1/-/g' > "$expected_output"

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'seq 100 111 | eddy.py '/1.1/s/1/-/g''test"
    exit 1
else
    echo "Passed 'seq 100 111 | eddy.py '/1.1/s/1/-/g''test"
fi

#===============================================================================
#
# different delimeter substitute command 
#
#===============================================================================

seq 1 5 | eddy.py 'sX[15]XzzzX' > "$actual_output"
seq 1 5 | 2041 eddy 'sX[15]XzzzX' > "$expected_output"

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'seq 1 5 | eddy.py 'sX[15]XzzzX''test"
    exit 1
else
    echo "Passed 'seq 1 5 | eddy.py 'sX[15]XzzzX''test"
fi

#===============================================================================
#
# regex address range substitute command 
#
#===============================================================================

seq 0 10 1000 | eddy.py '/4/,/6/s/0/-/g' > "$actual_output"
seq 0 10 1000 | 2041 eddy '/4/,/6/s/0/-/g' > "$expected_output"

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed 'seq 0 10 1000 | eddy.py '/4/,/6/s/0/-/g''test"
    exit 1
else
    echo "Passed 'seq 0 10 1000 | eddy.py '/4/,/6/s/0/-/g''test"
fi


