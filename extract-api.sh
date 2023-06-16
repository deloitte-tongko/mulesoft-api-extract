#!/bin/bash

# Config files
. config.sh

# Helper file
for HELPER_FILE in helper/* 
do
	. $HELPER_FILE
done

while getopts 'hn:pv:' opt; do
	case "$opt" in
		h) # help
			extract-api-usage;
			exit 0;
			;;

		n) # normal
			API_NAME="$OPTARG";
			VERBOSE=false;
			;;

		v) # verbose
			API_NAME="$OPTARG";
			VERBOSE=true;
			;;

		p) # prompted
			echo -n "Enter api name: ";
			read API_NAME;
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

if [[ $OPTIND -eq 1 ]]; then
	if [[ -z $1 ]]; then
		./extract-api.sh -p;
		exit 0;
	else
		./extract-api.sh -n $1;
		exit 0;
	fi
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
