#Quick switch accounts
account-switch () {   
    echo "Current account is..."
    az account show --query "{Name:name, Id:id}" --o table
    readarray -t lines < <(az account list --query "[*].{Id:id,Name:name,IsDefault:isDefault}" --o tsv)
    echo "Please select an account:"
    select choice in "${lines[@]}"; do
        #substring to pull out guid/sub-id
        az account set --s "${choice:0:36}"
        echo "Account set to..."
        az account show --query "{Name:name, Id:id}" --o table
        break #choice was made.
    done
}
