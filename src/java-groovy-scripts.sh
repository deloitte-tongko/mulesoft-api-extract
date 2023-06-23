# Find java files and calculate classes
JAVA_FILES=$(find $BASE_PATH -type f | egrep -E "*.java$" | wc -l);
JAVA_CLASS=0;

if [[ $JAVA_FILES -ne 0 ]]; then
	JAVA_CLASS=$(find $BASE_PATH -type f | egrep -E "*.java$" | xargs cat | egrep -E "(class|interface) ([[:alpha:]]|\s|,)*{" | egrep -Ev "\*" | wc -l);
fi

# Find groovy files and calculate classes
GROOVY_FILES=$(find $BASE_PATH -type f | egrep -E "*.groovy$" | wc -l);
GROOVY_CLASS=0;

if [[ $JAVA_FILES -ne 0 ]]; then
	GROOVY_CLASS=$(find $BASE_PATH -type f | egrep -E "*.groovy$" | xargs cat | egrep -E "class ([[:alpha:]]|\s|,)*{" | egrep -Ev "(\*|//)" | wc -l);
fi

SCRIPT_FILES=$(find $BASE_PATH/src/main/resources -type f | egrep -E "*.sql$" | wc -l);
JGS_FILES=$(expr $JAVA_FILES + $GROOVY_FILES + $SCRIPT_FILES);

HEADING="$HEADING,Number of Java/Groovy Code Classes/Scripts";
ROW="$ROW,$JAVA_FILES (Java) $GROOVY_FILES (Groovy) $SCRIPT_FILES (DB) $JGS_FILES (Total) - $(api-sizer $JGS_FILES 6 11 21)";

if [[ "$VERBOSE" = "true" ]]; then
	echo "Java, Groovy, Scripts: $JAVA_FILES (Java) $GROOVY_FILES (Groovy) $SCRIPT_FILES (DB) $JGS_FILES (Total) - $(api-sizer $JGS_FILES 6 11 21)";
fi
