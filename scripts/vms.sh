setvmstate () {
    rg=$1
    state=$2
    vmids=$(az vm list -g $rg --query "[].id" -o tsv)
    az vm $2 --no-wait --ids $vmids -o tsv
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