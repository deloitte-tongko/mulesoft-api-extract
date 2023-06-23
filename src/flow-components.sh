# WARNING !!! This script seems to overestimate the result due to hidden tags

FLOW_COMPONENTS=0;
if [[ -d "$BASE_PATH/src/main/app" ]]; then
	FLOW_COMPONENTS=$(find $BASE_PATH/src/main/app -type f | egrep -E ".xml$" | egrep -Ev "config.xml" | xargs cat | egrep -E "doc:name" | wc -l);
fi

HEADING="$HEADING,Flow/Sub-Flow Component Count";
ROW="$ROW,$FLOW_COMPONENTS $(api-sizer $FLOW_COMPONENTS 51 101 201)";

if [[ "$VERBOSE" = "true" ]]; then
	echo "Flow/Sub-Flow components: $FLOW_COMPONENTS $(api-sizer $FLOW_COMPONENTS 51 101 201)";
fi
