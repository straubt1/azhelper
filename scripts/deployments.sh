function deployments-all {
	deployments-show
}

function deployments-all-failed {
	deployments-show "Failed"
}

function deployments-all-succeeded {
	deployments-show "Succeeded"
}

function deployments-all-running {
	deployments-show "Running"
}

function deployments-show {
	state=$1
	groups=`az group list -o tsv --query "sort_by(@,&name)[].{Name:name}"`

	for a in $groups
	do
		echo "---${a}---"
		if [ -z ${state} ]; then
			az group deployment list -g $a -o table
		else
			az group deployment list -g $a -o table --query "[?properties.provisioningState=='${state}'].{Name:name,Time:properties.timestamp,State:properties.provisioningState}"
		fi
		echo ""
	done
}
