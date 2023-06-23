# Find all flow tags

FLOW=0;
if [[ -d "$BASE_PATH/src/main/app/" ]]; then
	FLOW=$(find $BASE_PATH/src/main/app/ -type f | egrep -E ".xml$" | xargs cat | egrep -E "</((sub-)?flow)|batch:job>" | wc -l);
fi

HEADING="$HEADING,Flow/Sub-Flow Count";
ROW="$ROW,$FLOW $(api-sizer $FLOW 26 76 150)";

if [[ "$VERBOSE" = "true" ]]; then
	echo "Flow/Sub-Flows: $FLOW $(api-sizer $FLOW 26 76 150)";
fi
