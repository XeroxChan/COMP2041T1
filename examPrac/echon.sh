#!/usr/bin/env dash

program=$0

if [ "$#" -ne 2 ]
then
	echo "Usage: ./echon.sh <number of lines> <string>"
	exit
fi



n=$1
string=$2

if [ "$n" -ge 0 ] 2>/dev/null
then
	:
else
	echo "$program: argument 1 must be a non-negative integer"
	exit
fi
i=0


while [ "$i" -lt "$n" ]
do
	echo "$string"
	i=$(( i + 1 ))
done
