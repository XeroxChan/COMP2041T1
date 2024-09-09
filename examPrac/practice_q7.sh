#!/bin/dash

for filename in "$@"
do
	case "$(head -1 "$filename")" in
		*perl*)   extension="pl" ;;
		*python*) extension="py" ;;
		*sh*)     extension="sh" ;;
		*)        extension=""   ;;
	esac
	
	new_filename="$filename.$extension"
	
	if echo "$filename" | grep -Eq "\."
	then
		echo "# $filename already has an extension"
	elif [ "$(head -c2 "$filename")" != '#!' ]
	then
		echo "# $filename does not have a #! line"
	elif [ -z "$extension" ]
	then
		echo "# $filename no extension for #! line"
	elif [ -e "$new_filename" ]
	then
		echo "# $new_filename already exists"
	else
		echo "mv $filename $new_filename"
	fi
done
