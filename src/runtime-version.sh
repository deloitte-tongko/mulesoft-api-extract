HEADING="$HEADING,Runtime Version";

echo $TODO > tmp/runtime-version;
parent_tag=false;

if [[ -f $BASE_PATH/pom.xml ]]; then
	cat $BASE_PATH/pom.xml | while read -r line; do
		if [[ $parent_tag == "false" ]]; then
			if [[ $line =~ "<parent>" ]]; then
				parent_tag=true;
			fi
		elif [[ $parent_tag == "true" ]]; then
			if [[ $line =~ "</parent>" ]]; then
				parent_tag=false;
			elif [[ $line =~ "<version>" ]]; then
				echo $line | egrep -Eo "([0-9]|\.|-)*" > tmp/runtime-version;
			fi
		fi
	done
fi

RUNTIME_VERSION=$(cat tmp/runtime-version);
ROW="$ROW,$RUNTIME_VERSION";


if [[ "$VERBOSE" = "true" ]]; then
	echo "Runtime Version: $RUNTIME_VERSION";
fi
