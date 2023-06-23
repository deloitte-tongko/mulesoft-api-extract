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
REPLACE=false;
NO_OUTPUT=false;
OUTPUT_FILE_CSV="$OUTPUT_PATH/$OUTPUT_FILE";

while getopts 'hi:no:rv' opt; do
	case "$opt" in
		h) # help
			extract-api-usage;
			exit 0;
			;;

		i) # input API
			API_NAME="$OPTARG";
			;;

		n) # no output
			NO_OUTPUT=true;
			;;

		o) # output file
			OUTPUT_FILE_CSV="$OPTARG";
			;;

		v) # verbose
			VERBOSE=true;
			;;

		r) # replace output data
			REPLACE=true;
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

# Make an tmp directory
if [[ ! -d "$TMP_PATH" ]]; then
	mkdir "$TMP_PATH";
fi

# Clone repository
BASE_PATH="$REPOSITORY_OUTPUT_PATH/$API_NAME-$REPOSITORY_BRANCH";
REPO_PATH="$REPOSITORY_BASE/$API_NAME";

if [[ -d  "$BASE_PATH" ]]; then
	echo "Repository already cloned for $API_NAME, using local repository";
else
	[[ ! $(git clone "$REPO_PATH:$REPOSITORY_OUTPUT") ]] && exit 1;
fi

if [[ ! -d "$SRC_PATH" ]]; then
	mkdir "$SRC_PATH";
fi

# CSV data
HEADING="API Name";
ROW="$API_NAME";

# Run the analysis
while read -r src; do
	. "$SRC_PATH"/$src;
done < $SRCS_FILE

if [[ $NO_OUTPUT = false ]]; then
	if [[ ! -d $OUTPUT_PATH ]]; then
		mkdir $OUTPUT_PATH;
	fi

	if [[ ! -f $OUTPUT_FILE_CSV || $REPLACE = "true" ]]; then
		echo $HEADING > $OUTPUT_FILE_CSV;
	fi

	echo $ROW >> $OUTPUT_FILE_CSV;

	echo "api $API_NAME has been extracted";
fi
