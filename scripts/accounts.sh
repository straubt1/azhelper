BOLD="\e[1m"
NORM="\e[0m"
C_DEF="\e[;39m"
C_ALT="\e[;32m"

function get-accounts {
	OIFS=$IFS;
	# OOFS=$OFS;
	IFS='
'
	# OFS=$'\t'
	accounts=`az account list -o tsv --query "[].{Name:name,Id:id,Active:isDefault}" --all`
	accountsArray=$accounts;

	i=0
	for a in $accountsArray
	do
		a_name="${a[0]}"
		a_id="${a[1]}"
		a_active="${a[2]}"

		if [ $((i%2)) -eq 0 ]; then
			printf "${C_DEF}"
		else
			printf "${C_ALT}"
		fi
		printf "[%d] %s %s %s\n" "${i}" "${a_name}" "${a_id}" "${a_active}"
		((++i))
	done
	printf "${C_DEF}"

	IFS=$OIFS;
	# OFS=$OOFS;

	echo -n "Switch? "
	read account_index

	if [ -n "$account_index" ]; then set-account $account_index; fi
	
}

function set-account {
	index=$1
	OIFS=$IFS;
	IFS='
'
	account=`az account list -o tsv --query "[${index}].id" --all`
	accountsArray=$accounts;

	az account set -s ${account}
	account_info=$(az account show -s ${account} -o tsv --query "{Name:name,Id:id}")
	printf "Account Set: %s\n" "$account_info"
	IFS=$OIFS;
}


