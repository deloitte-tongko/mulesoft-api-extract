GLOBAL_ELEMENT=0;
if [[ -f "$BASE_PATH/src/main/app/config.xml" ]]; then
	GLOBAL_ELEMENT=$(cat $BASE_PATH/src/main/app/config.xml | egrep -E "<spring:bean|doc:name" | wc -l);
fi

HEADING="$HEADING,Global Element Count";
ROW="$ROW,$GLOBAL_ELEMENT $(api-sizer $GLOBAL_ELEMENT 11 26 51)";

if [[ "$VERBOSE" = "true" ]]; then
	echo "Global Element Count: $GLOBAL_ELEMENT $(api-sizer $GLOBAL_ELEMENT 11 26 51)";
fi
