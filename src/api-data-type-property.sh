DATATYPE_PROP=0;
DATATYPE_PROP_AVG=0;

if [[ -d $BASE_PATH/src/main/api ]]; then
	DATATYPE_PROP=$(find $BASE_PATH/src/main/api -type d | egrep -E "datatype|data-type" | xargs -I% find "%" -type f | xargs cat | egrep -E "type" | egrep -Ev "object" | wc -l);
	if [[ $DATATYPE_FILES -gt 0 ]]; then
		DATATYPE_PROP_AVG=$(expr $DATATYPE_PROP / $DATATYPE_FILES);
	fi
fi

HEADING="$HEADING,API Data Type Property Count";
ROW="$ROW,$DATATYPE_PROP_AVG $(api-sizer $DATATYPE_PROP_AVG 6 11 21)";

if [[ "$VERBOSE" = "true" ]]; then
	echo "API Data Type Properties: $DATATYPE_PROP_AVG $(api-sizer $DATATYPE_PROP_AVG 6 11 21)";
fi
