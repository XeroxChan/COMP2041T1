#!/usr/bin/env dash

for filename in "$@"
do
	for filename2 in "$@"
	do
		if [ "$filename" = "$filename2" ]
		then
			continue
		elif diff "$filename" "$filename2" > /dev/null
		then
			echo "ln -s $filename $filename2"
		fi
	done
done
