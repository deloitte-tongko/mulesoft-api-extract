COMMENTS=""
if [[ -d "$BASE_PATH/src/main/app" && -f $BASE_PATH/src/main/app/config.xml ]]; then
	COMMENT=$(cat $BASE_PATH/src/main/app/config.xml | egrep -Eo "<([[:alpha:]]|:|-)*\s" | egrep -Eo "[^<].*" | egrep -Ev "spring:" | sort --unique | xargs | sed 's/ /\//g' | tr -d '\r');
fi

HEADING="$HEADING,comments";
ROW="$ROW,$COMMENT";

if [[ "$VERBOSE" = "true" ]]; then
	echo "comments: $COMMENT";
fi
