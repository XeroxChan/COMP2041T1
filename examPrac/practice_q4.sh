#!/bin/dash

filename=$1

sorted_numbers=$(sort -n "$filename")

start=$(echo "$sorted_numbers" | head -n1)

for line in $sorted_numbers
do
	if [ "$start" -ne "$line" ]
	then
		missing=$start
		echo "$missing"
		exit
	fi
	start=$(( start + 1 ))
done
