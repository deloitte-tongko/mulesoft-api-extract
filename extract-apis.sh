if [[ -d output/ && -f output/output.csv ]]; then
	rm output/output.csv;
fi

. config.sh;

for HELPER_FILE in helper/*
do
	. $HELPER_FILE;
done

while getopts 'hnpv' opt; do
	case "$opt" in
		h) # help
			extract-apis-usage
			exit 0;
			;;

		n) # normal
			while read -r api; do
				./extract-api.sh -n $api;
			done < $APIS_FILE
			;;

		v) # verbose
			while read -r api; do
				./extract-api.sh -v $api;
			done < $APIS_FILE
			;;

		p) # prompted
			while true; do
				./extract-api.sh -p;
			done
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
		./extract-apis.sh -n;
		exit 0;
	fi
fi
