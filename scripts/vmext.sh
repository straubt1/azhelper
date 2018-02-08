get-vmextension()
{
	vmid=$1
	az vm extension show --ids $vmid --query "{Name:name,State:provisioningState}" -o table
}

function vmext-all
{
	vmext_ids=$(az resource list -o tsv --query "[?contains(type, 'Microsoft.Compute/virtualMachines/extensions')].id")
	for ext in $vmext_ids
    do
		get-vmextension $ext &
    done
	wait
}