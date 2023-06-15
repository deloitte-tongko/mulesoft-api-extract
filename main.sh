# API parameter parsing
if [[ -z $1 ]]; then
	echo -n "Enter api name: ";
	read API_NAME;
else
	API_NAME=$1;
fi

# Config files
. config.sh

# Helper file
for HELPER_FILE in helper/* 
do
	. $HELPER_FILE
done

# Make an output directory
if [[ ! -d "$REPOSITORY_OUTPUT_PATH" ]]; then
	mkdir "$REPOSITORY_OUTPUT_PATH";
fi

# Clone repository
BASE_PATH="$REPOSITORY_OUTPUT_PATH/$API_NAME-$REPOSITORY_BRANCH";
REPO_PATH="$REPOSITORY_BASE/$API_NAME";
if [[ -d  "$BASE_PATH" ]]; then
	echo "Repository already cloned, using current version for analysis";
else
	[[ ! $(git clone "$REPO_PATH:$REPOSITORY_OUTPUT") ]] && return 1;
fi

# Run the analysis
if [[ ! -d "$SRC_PATH" ]]; then
	mkdir "$SRC_PATH";
fi

# CSV data
HEADING="API Name";
ROW="$API_NAME";

for API in ${SRC_FILES[@]}; do
	. "$SRC_PATH"/$API;
done

if [[ ! -d $OUTPUT_PATH ]]; then
	mkdir $OUTPUT_PATH;
fi

if [[ ! -f $OUTPUT_PATH/$OUTPUT_FILE || $2 -eq "--reset" ]]; then
	echo $HEADING > $OUTPUT_PATH/$OUTPUT_FILE;
fi

echo $ROW >> $OUTPUT_PATH/$OUTPUT_FILE;
