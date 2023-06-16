#!/bin/bash

# Config files
. config.sh

# Helper file
for HELPER_FILE in helper/* 
do
	. $HELPER_FILE
done

API_NAME="";
VERBOSE=false;
while getopts 'hvi:' opt; do
	case "$opt" in
		h) # help
			extract-api-usage;
			exit 0;
			;;

		v) # verbose
			VERBOSE=true;
			;;

		i) # input API
			API_NAME="$OPTARG";
			;;

		:) # argument requirement
			echo -e "option requires an argument.\n$(main-usage)";
			exit 1;
			;;

		?) # invalid option
			extract-api-usage;
			exit 1
			;;
	esac
done
shift "$(($OPTIND -1))";

if [[ -z $API_NAME ]]; then
	echo -n "Enter api name: ";
	read API_NAME;
fi

# Make an output directory
if [[ ! -d "$REPOSITORY_OUTPUT_PATH" ]]; then
	mkdir "$REPOSITORY_OUTPUT_PATH";
fi

# Clone repository
BASE_PATH="$REPOSITORY_OUTPUT_PATH/$API_NAME-$REPOSITORY_BRANCH";
REPO_PATH="$REPOSITORY_BASE/$API_NAME";
if [[ -d  "$BASE_PATH" ]]; then
	echo "Repository already cloned for $API_NAME, using local repository";
else
	[[ ! $(git clone "$REPO_PATH:$REPOSITORY_OUTPUT") ]] && exit 1;
fi

# Run the analysis
if [[ ! -d "$SRC_PATH" ]]; then
	mkdir "$SRC_PATH";
fi

# CSV data
HEADING="API Name";
ROW="$API_NAME";

while read -r src; do
	. "$SRC_PATH"/$src;
done < $SRCS_FILE

if [[ ! -d $OUTPUT_PATH ]]; then
	mkdir $OUTPUT_PATH;
fi

if [[ ! -f $OUTPUT_PATH/$OUTPUT_FILE || $2 -eq "--reset" ]]; then
	echo $HEADING > $OUTPUT_PATH/$OUTPUT_FILE;
fi

echo "api $API_NAME has been extracted";
echo $ROW >> $OUTPUT_PATH/$OUTPUT_FILE;
