COMMENT=$(cat $BASE_PATH/src/main/app/config.xml | egrep -Eo "<([[:alpha:]]|:|-)*\s" | egrep -Eo "[^<].*" | egrep -Ev "spring:" | sort --unique | xargs | sed 's/ /\//g');

HEADING="$HEADING, comments";
ROW="$ROW, $COMMENT";

echo "comments: $COMMENT";
