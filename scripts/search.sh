# search for Resource Group by name
function search-group () {
  query=$1
  az group list --query "[?name | contains(@,'$query')].{ResourceGroup:name}" -o table
}

# search for VM by name
function search-vms () {
  query=$1
  az vm list --query "[?name | contains(@,'$query')].{ResourceGroup:resourceGroup,Name:name}" -o table
}

# search for VM by name, return space seperated list of ids
function search-vms-ids () {
  query=$1
  az vm list --query "[?name | contains(@,'$query')].id" -o tsv | tr '\r\n' ' '
}

# search for VM by name, return detailed including power state
function search-vms-details () {
  query=$1
  az vm show --ids $(search-vms-ids $query) -d -o table --query "[].{ResourceGroup:resourceGroup,Name:name,State:powerState}"
}

# search for VM given it's IP address
function search-vm-from-ip {
 ip=$1
 az network nic list --query "[?ipConfigurations[?privateIpAddress=='$ip']].{ResourceGroup:resourceGroup,\"VM Name\":name,\"VM Id\":virtualMachine.id}" -o table
}