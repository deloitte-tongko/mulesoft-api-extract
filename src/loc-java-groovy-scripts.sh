# Find java files and calculate classes
JAVA_LINES=$(find $BASE_PATH -type f | egrep -E "*.java$" | xargs cat | wc -l);
JAVA_LINES_AVG=0;

if [[ $JAVA_FILES -ne 0 ]]; then
	JAVA_LINES_AVG=$(expr $JAVA_LINES / $JAVA_FILES);
fi

# Find groovy files and calculate classes
GROOVY_LINES=$(find $BASE_PATH -type f | egrep -E "*.groovy$" | xargs cat | wc -l);
GROOVY_LINES_AVG=0;

if [[ $GROOVY_FILES -ne 0 ]]; then
	GROOVY_LINES_AVG=$(expr $GROOVY_LINES / $GROOVY_FILES);
fi

SCRIPT_LINES=$(find $BASE_PATH -type f | egrep -E "*.sql$" | xargs cat | wc -l);
SCRIPT_LINES_AVG=0;

if [[ $SCRIPT_FILES -ne 0 ]]; then
	SCRIPT_LINES_AVG=$(expr $SCRIPT_LINES / $SCRIPT_FILES);
fi

JGS_LINES=$(expr $JAVA_LINES + $GROOVY_LINES + $SCRIPT_LINES);
JGS_LINES_AVG=0;

if [[ $JGS_FILES -ne 0 ]]; then
	JGS_LINES_AVG=$(expr $JGS_LINES / $JGS_FILES);
fi

HEADING="$HEADING,Average Lines of Code per Class/Script";
ROW="$ROW,$JAVA_LINES_AVG (Java) $GROOVY_LINES_AVG (Groovy) $SCRIPT_LINES_AVG (DB) $JGS_LINES_AVG (Total) - $(api-sizer $JGS_LINES_AVG 26 76 151)";

if [[ "$VERBOSE" = "true" ]]; then
	echo "Average lines of code per class/script: $JAVA_LINES_AVG (Java) $GROOVY_LINES_AVG (Groovy) $SCRIPT_LINES_AVG (DB) - $(api-sizer $JGS_LINES_AVG 26 76 151)";
fi
