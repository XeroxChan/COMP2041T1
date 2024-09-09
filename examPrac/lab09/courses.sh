#!/bin/dash

courseName=$1

curl --silent --location http://www.timetable.unsw.edu.au/2024/{$courseName}KENS.html | grep -Eo $courseName[0-9]{4}.*[a-zA-Z]* | rev | cut -c10- | rev | grep -Ev [0-9]{4}$ 
