. config.sh;

for HELPER_FILE in helper/*
do
	. $HELPER_FILE;
done

optstring="";
inputfile=false;
while getopts 'hio:rv' opt; do
	case "$opt" in
		h) # help
			extract-apis-usage
			exit 0;
			;;

		i) # input file 
			inputfile=true;
			;;

		o) # output file
			optstring+=" -o $OPTARG";
			;;

		r) # replace data
			if [[ -d "$OUTPUT_PATH" && -f "$OUTPUT_PATH/$OUTPUT_FILE" ]]; then
				rm "$OUTPUT_PATH/$OUTPUT_FILE";
			fi
			;;

		v) # verbose
			optstring+=" -v";
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
	while read -r api; do
		api=$(echo $api | tr -d '\r');
		./extract-api.sh$optstring -i $api;
	done < $APIS_FILE
elif [[ "$inputfile" = "false" ]]; then
	while true; do
		./extract-api.sh$optstring;
	done
fi
