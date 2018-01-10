# get all ips in a subscription, can also pass a resource group name to limit to just a resource group
function get-ips {
 RG=$1
 if [ -z ${RG} ]; then
   az network nic list -o table --query "[].{Name:name,PrivateIP:ipConfigurations[*].privateIpAddress|join(',',@)}"
 else
   az network nic list -o table --query "[].{Name:name, PrivateIP:join(',', @ipConfigurations[*].privateIpAddress|join(',',@))}" -g ${RG}
 fi
}

# Get All IPs in a subscription or resource group (if specified)
function get-ips-detailed {
  RG=$1
  echo "NIC List..."
  if [ -z ${RG} ]; then
    az vm list-ip-addresses -o table
    echo "\nLoad Balanceers..."
    az network lb list -o table --query "[].{Name:name,PrivateIP:frontendIpConfigurations[0].privateIpAddress}"
    echo "\nPublic IPs..."
    az network public-ip list -o table --query '[].{Name:name,RG:resourceGroup,PublicIP:ipAddress}'
  else
    az vm list-ip-addresses -g ${RG} -o table
    echo "\nLoad Balanceers..."
    az network lb list -o table --query "[].{Name:name,PrivateIP:frontendIpConfigurations[0].privateIpAddress}" -g ${RG}
    echo "\nPublic IPs..."
    az network public-ip list -o table --query '[].{Name:name,RG:resourceGroup,PublicIP:ipAddress}' -g ${RG}
  fi
}
