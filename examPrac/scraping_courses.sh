#!/usr/bin/env dash

program="$0"

case $# in
2)
	YEAR="$1"
	CODE="$2"
	;;
*)
	echo "Usage: $program <year> <course-prefix>" >& 2
	exit
esac

if [ "$YEAR" -ge 2019 ] 2> /dev/null && [ "$YEAR" -le 2023 ] 2> /dev/null
then
	:
else
	echo "$program: argument 1 must be an integer between 2019 and 2023"
	exit
fi

url1="https://www.handbook.unsw.edu.au/api/content/render/false/query/+unsw_psubject.implementationYear:$YEAR%20+unsw_psubject.studyLevel:undergraduate%20+unsw_psubject.educationalArea:$CODE*%20+unsw_psubject.active:1%20+unsw_psubject.studyLevelValue:ugrd%20+deleted:false%20+working:true%20+live:true/orderby/unsw_psubject.code%20asc/limit/10000/offset/0"

url2="https://www.handbook.unsw.edu.au/api/content/render/false/query/+unsw_psubject.implementationYear:$YEAR%20+unsw_psubject.studyLevel:postgraduate%20+unsw_psubject.educationalArea:$CODE*%20+unsw_psubject.active:1%20+unsw_psubject.studyLevelValue:ugrd%20+deleted:false%20+working:true%20+live:true/orderby/unsw_psubject.code%20asc/limit/10000/offset/0"


