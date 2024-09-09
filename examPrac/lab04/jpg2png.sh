#! /bin/dash

for jpg_file in *.jpg; do
    png_file=$(echo "$jpg_file" | sed -E 's/.jpg$/.png/')
    if [ -e "$png_file" ]; then
        echo "$png_file" already exists
        exit 1
    fi
    convert "$jpg_file" "$png_file" 2> /dev/null && rm -- "$jpg_file"
done
