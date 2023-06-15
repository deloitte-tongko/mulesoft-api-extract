# Find all flow tags
FLOW=$(find $BASE_PATH/src/main/app/ -type f | egrep -E ".xml$" | xargs cat | egrep -E "</((sub-)?flow)|batch:job>" | wc -l);

HEADING="$HEADING, Flow/Sub-Flow Count";
ROW="$ROW, $FLOW $(api-sizer $FLOW 26 76 150)";

echo "Flow/Sub-Flows: $FLOW $(api-sizer $FLOW 26 76 150)";
