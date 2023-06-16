
. config.sh;

for HELPER_FILE in helper/*
do
	. $HELPER_FILE;
done

while getopts 'hivpr' opt; do
	case "$opt" in
		h) # help
			extract-apis-usage
			exit 0;
			;;

		i) # normal
			while read -r api; do
				./extract-api.sh -i $api;
			done < $APIS_FILE
			exit 0;
			;;

		v) # verbose
			while read -r api; do
				./extract-api.sh -v $api;
			done < $APIS_FILE
			exit 0;
			;;

		p) # prompted
			while true; do
				./extract-api.sh -p;
			done
			exit 0;
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

if [[ $OPTIND -eq 1 ]]; then
	if [[ -z $1 ]]; then
		./extract-apis.sh -i;
		exit 0;
	fi
fi
