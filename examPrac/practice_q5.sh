#!/bin/dash

pattern=$1
file=$2

matching_lines=$(grep -E "^${pattern}\|" "$file")
award_year=$(grep -E "^${pattern}\|" "$file"| cut -d'|' -f2 | sort -n | uniq)


if [ -z "$matching_lines" ]
then
	echo "No award matching '$1'"
	exit
fi

start_year=$(echo "$award_year" | head -n1)
last_year=$(echo "$award_year" | tail -n1)

full_length=$(seq "$start_year" "$last_year")


missing=$(echo "$award_year" "$full_length" | tr ' ' '\n' | sort | uniq -u)

if [ -n "$missing" ]
then
	echo "$missing"
fi
