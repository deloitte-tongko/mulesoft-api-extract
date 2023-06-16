MUNIT_TEST=$(find $BASE_PATH/src/test/munit/ -type f | egrep -E ".xml$" | xargs cat | egrep -E "</munit:test>" | wc -l);

HEADING="$HEADING, Number of MUnit Tests";
ROW="$ROW, $MUNIT_TEST $(api-sizer $MUNIT_TEST 26 51 101)";

if [[ "$VERBOSE" = "true" ]]; then
	echo "MUnit Tests: $MUNIT_TEST $(api-sizer $MUNIT_TEST 26 51 101)";
fi
