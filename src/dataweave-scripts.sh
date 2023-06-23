# Finds the number of Externalised DataWeave Scripts with more than 7 lines (2 properties)
# Need to also include Embedded

#DWL_FILES=$(find $BASE_PATH/src/main -type f -exec awk 'FNR==5{print FILENAME; nextfile}' {} + | egrep -E ".dwl$" | wc -l);

DWL_FILES_EXTERNAL=$(find $BASE_PATH/src/main -type f | egrep -E ".dwl$" | xargs egrep -Ec "[[:alpha:]]*:" | egrep -Eo "[0-9]*$" | awk '$1>2' | wc -l);

if [[ ! -d tmp ]]; then
	mkdir tmp;
fi

echo 0 > tmp/dw-files-embedded;
DW_PROP=0;
MATCH_FOUND=false;

find $BASE_PATH/src/main -type f | egrep -E ".xml$" | while read -r file; do
	cat $file | while read -r line; do
		if [[ $MATCH_FOUND == false ]]; then
			if [[ $line =~ "<dw:set-payload><![CDATA[%dw" ]]; then
				MATCH_FOUND=true;
			fi
		else
			if [[ $line =~ "/dw:set-payload" ]]; then
				if [[ $DW_PROP -gt 2 ]]; then
					expr $(cat tmp/dw-files-embedded) + 1 > tmp/dw-files-embedded;
				fi
				MATCH_FOUND=false;
				DW_PROP=0
			else
				if [[ $line =~ [:alpha:]*: ]]; then
					DW_PROP=$(expr $DW_PROP + 1);
				fi
			fi
		fi
	done
done

DWL_FILES=$(expr $DWL_FILES_EXTERNAL + $(cat tmp/dw-files-embedded));

HEADING="$HEADING,Number of DataWeave Scripts (Embedded and Externalised) with more than 2 properties/fields assigned";
ROW="$ROW,$DWL_FILES $(api-sizer $DWL_FILES 11 21 50)";

if [[ "$VERBOSE" = "true" ]]; then
	echo "Number of DS: $DWL_FILES $(api-sizer $DWL_FILES 11 21 50)";
fi
