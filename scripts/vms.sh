setvmstate () {
    rg=$1
    state=$2
    vmids=$(az vm list -g $rg --query "[].id" -o tsv)
    az vm $2 --no-wait --ids $vmids -o tsv
}
setvmstate_byid () {
    id=$1
    state=$2
    az vm $2 --no-wait --ids $id -o tsv
}

function vms-start () {
    rgs=$@
    for rg in $rgs; do setvmstate "$rg" start & done
    wait
}

function vms-stop () {
    rgs=$@
    for rg in $rgs; do setvmstate "$rg" stop & done
    wait
}

function vms-deallocate () {
    rgs=$@
    for rg in $rgs; do setvmstate "$rg" deallocate & done
    wait
}

function vms-restart () {
    rgs=$@
    for rg in $rgs; do setvmstate "$rg" restart & done
    wait
}

getvmdetails () {
    r=$1
    az vm list -g $r -o table --show-details
}

function vms-show () {
    rgs=$@
    for rg in $rgs; do getvmdetails "$rg" & done
    wait
}

function vms-show-all() {
    az vm list -o table --show-details
}

function vms-start-all () {
    vms_ids=$(az vm list -o tsv --query "[].id")
    for vm in $vms_ids; do setvmstate_byid "$vm" start & done
    wait
}

function vms-restart-all-query () {
    query=$1
    vms_ids=$(az vm list -o tsv --query "[?name | contains(@,'${query}')].id")
    echo $vms_ids
    for vm in $vms_ids; do setvmstate_byid "$vm" restart & done
    wait
}

function vms-restart-all () {
    vms_ids=$(az vm list -o tsv --query "[].id")
    for vm in $vms_ids; do setvmstate_byid "$vm" restart & done
    wait
}

function vms-stop-all () {
    vms_ids=$(az vm list -o tsv --query "[].id")
    for vm in $vms_ids; do setvmstate_byid "$vm" stop & done
    wait
}

function vms-deallocate-all () {
    vms_ids=$(az vm list -o tsv --query "[].id")
    for vm in $vms_ids; do setvmstate_byid "$vm" deallocate & done
    wait
}