MUNIT_MOCK_SAMPLE=$(find $BASE_PATH/src/test/resources/ -type f | egrep -Ev ".properties$" | wc -l);

HEADING="$HEADING,Number of MUnit Mock/Sample Files";
ROW="$ROW,$MUNIT_MOCK_SAMPLE $(api-sizer $MUNIT_MOCK_SAMPLE 11 26 51)";

if [[ "$VERBOSE" = "true" ]]; then
	echo "MUnit Mock/Sample Files: $MUNIT_MOCK_SAMPLE $(api-sizer $MUNIT_MOCK_SAMPLE 11 26 51)";
fi
