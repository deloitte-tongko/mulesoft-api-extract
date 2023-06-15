# WARNING!!! Overestimates due to hidden tags
GLOBAL_ELEMENT=$(cat $BASE_PATH/src/main/app/config.xml | egrep -E "<spring:bean|doc:name" | wc -l);

HEADING="$HEADING, Global Element Count";
ROW="$ROW, $GLOBAL_ELEMENT $(api-sizer $GLOBAL_ELEMENT 11 26 51)";

echo "Global Element Count: $GLOBAL_ELEMENT $(api-sizer $GLOBAL_ELEMENT 11 26 51)";
