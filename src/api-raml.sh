RAML_SIZE=0;
HTTP_REQUEST_METHODS="(get|head|post|put|delete|connect|options|trace|patch):";

: <<'PREVIOUS_IMPLEMENTATION'
# Count files in src/main/api
if [[ -d $BASE_PATH/src/main/api ]]; then
	RAML_SIZE=$(find $BASE_PATH/src/main/api/ -maxdepth 1 -not -type d | xargs cat | egrep -E $HTTP_REQUEST_METHODS | wc -l);
fi

# Count files in src/main/app
if [[ -d $BASE_PATH/src/main/app ]]; then
	RAML_SIZE_APP=$(find $BASE_PATH/src/main/app/ -type f | egrep -E ".xml$" | xargs cat | egrep -E "allowedMethods" | wc -l);
	RAML_SIZE=$(expr $RAML_SIZE + $RAML_SIZE_APP);
fi

HEADING="$HEADING, API RAML (Resource and Verb)";
ROW="$ROW, $RAML_SIZE $(api-sizer $RAML_SIZE 6 11 12)";

echo "RAML size: $RAML_SIZE $(api-sizer $RAML_SIZE 6 11 12)";
PREVIOUS_IMPLEMENTATION

# Count the number of flows
RAML_SIZE=0;
if [[ -f $BASE_PATH/src/main/app/api.xml ]]; then
	RAML_SIZE=$(expr $(cat $BASE_PATH/src/main/app/api.xml | egrep -E "</(sub-)?flow|batch:job>" | wc -l) - 1);
fi

HEADING="$HEADING,API RAML (Resource and Verb)";
ROW="$ROW,$RAML_SIZE $(api-sizer $RAML_SIZE 6 11 12)";

if [[ "$VERBOSE" = "true" ]]; then
	echo "RAML size: $RAML_SIZE $(api-sizer $RAML_SIZE 6 11 12)";
fi
