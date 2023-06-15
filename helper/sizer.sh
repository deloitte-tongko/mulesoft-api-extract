api-sizer() {
	if [[ $1 -lt $2 ]]; then
		echo "(S)";
	elif [[ $1 -lt $3 ]]; then
		echo "(M)";
	elif [[ $1 -lt $4 ]]; then
		echo "(L)";
	else
		echo "(XL)";
	fi
}
