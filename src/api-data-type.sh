# Count the number of files in src/main/api
DATATYPE_FILES=0;
if [[ -d $BASE_PATH/src/main/api ]]; then
	DATATYPE_FILES=$(find $BASE_PATH/src/main/api/ -type d | egrep -E "datatypes|data-types" | xargs -I% find "%" -maxdepth 1 -not -type d | wc -l);
fi

HEADING="$HEADING,API Data Type Count";
ROW="$ROW,$DATATYPE_FILES $(api-sizer $DATATYPE_FILES 4 9 16)";

if [[ "$VERBOSE" = "true" ]]; then
	echo "API Data Types: $DATATYPE_FILES $(api-sizer $DATATYPE_FILES 4 9 16)";
fi
