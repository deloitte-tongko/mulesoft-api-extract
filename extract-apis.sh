. config.sh;

for HELPER_FILE in helper/*
do
	. $HELPER_FILE;
done

optstring="-";
inputfile=false;
while getopts 'hvir' opt; do
	case "$opt" in
		h) # help
			extract-apis-usage
			exit 0;
			;;

		v) # verbose
			optstring+="v";
			;;

		i) # input file 
			optstring+="i";
			inputfile=true;
			;;

		r) # replace data
			if [[ -d "$OUTPUT_PATH" && -f "$OUTPUT_PATH/$OUTPUT_FILE" ]]; then
				rm "$OUTPUT_PATH/$OUTPUT_FILE";
			fi
			;;

		:) # argument requirement
				echo -e "option requires an argument.\n$(main-usage)";
				exit 1
				;;

		?) # invalid option
			extract-api-usage;
			exit 1
			;;
	esac
done
shift "$(($OPTIND -1))";

if [[ "$inputfile" = "true" ]]; then
	echo "yes";
	while read -r api; do
		./extract-api.sh $optstring $api;
	done < $APIS_FILE
elif [[ "$inputfile" = "false" ]]; then
	while true; do
		./extract-api.sh $optstring;
	done
fi
