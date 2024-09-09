#! /bin/dash

for file_name in *
do
	if [ ! -f "$file_name" ]
	then
		continue
	fi
	file_length=$(wc -l < "$file_name")
	
	if [ "$file_length" -lt 10 ]
	then
		small_file="$small_file $file_name"
	elif [ "$file_length" -ge 100 ]
	then
		large_file="$large_file $file_name"
	else
		medium_file="$medium_file $file_name"
	fi
done

echo "$small_file" > temp_small.txt 
tr '[:blank:]' '\n' < temp_small.txt > temp_small_sort.txt 
sort temp_small_sort.txt > /dev/null
tr '\n' ' ' < temp_small_sort.txt > temp_small_sorted.txt

echo "$medium_file" > temp_medium.txt 
tr '[:blank:]' '\n' < temp_medium.txt > temp_medium_sort.txt 
sort temp_medium_sort.txt > /dev/null
tr '\n' ' ' < temp_medium_sort.txt > temp_medium_sorted.txt

echo "$large_file" > temp_large.txt 
tr '[:blank:]' '\n' < temp_large.txt > temp_large_sort.txt 
sort temp_large_sort.txt > /dev/null
tr '\n' ' ' < temp_large_sort.txt > temp_large_sorted.txt


echo "Small files:$small_file"
echo "Medium-sized files:$medium_file"
echo "Large files:$large_file"

#remove all the temp files created
rm temp*
