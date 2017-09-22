# get all ips in a subscription, can also pass a resource group name to limit to just a resource group
function get-ips {
 RG=$1
 if [ -z ${RG} ]; then
   az network nic list -o table --query "[].{Name:name,PrivateIP:ipConfigurations[*].privateIpAddress|join(',',@)}"
 else
   az network nic list -o table --query "[].{Name:name, PrivateIP:join(',', @ipConfigurations[*].privateIpAddress|join(',',@))}" -g ${RG}
 fi
}