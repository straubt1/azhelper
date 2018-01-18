[![](https://images.microbadger.com/badges/version/straubt1/azhelper.svg)](https://microbadger.com/images/straubt1/azhelper "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/straubt1/azhelper.svg)](https://microbadger.com/images/straubt1/azhelper "Get your own image badge on microbadger.com")[![](https://dockerbuildbadges.quelltext.eu/status.svg?organization=straubt1&repository=azhelper)](https://dockerbuildbadges.quelltext.eu/status.svg?organization=straubt1&repository=azhelper "Dockerhub Build Status")


# azhelper
Docker image to be used to interact with Microsoft's Azure Cloud.
Contains the latest Azure CLI 2.0 utility and a bunch of helper commands.
Running the container with mapped volumes allows for persistance after logging in.

## How to Use
### First Time
Make sure you have the `.azure` directory created, you will need to map this volume when running the container.
This directory stores your az cli configs and access tokens so you do not need to login every time.
`mkdir ${HOME}/.azure`

### Run on Mac/Linux
`docker run --rm -it -v ${HOME}/.azure:/root/.azure straubt1/azhelper`

### Run on Windows
`docker run --rm -it -v %HOME%/.azure:/root/.azure straubt1/azhelper`
*note:* windows needs slightly different syntax to map a windows path to a linux one.

Once you are up and running with the container you need to login with the `az login` command.
Follow the login prompt by using the address provided and the code given to authenticate against your Azure Subscription.
The process looks something like this:
```
docker run -it -v /${HOME}/.azure:/root/.azure straubt1/azhelper
bash-4.3# az login
To sign in, use a web browser to open the page https://aka.ms/devicelogin and enter the code ZZZZZZZ to authenticate.
[
  {
    "cloudName": "AzureCloud",
    "id": "",
    "isDefault": true,
    "name": "",
    "state": "Enabled",
    "tenantId": "",
    "user": {
      "name": "tstraub@cardinalsolutions.com",
      "type": "user"
    }
  }
]
```

Congatulations, you are all setup!
Verify what subsciptions you have access to by running a `az account list -o table`.
```
bash-4.3# az account list -o table
Name                             CloudName    SubscriptionId                        State    IsDefault
-------------------------------  -----------  ------------------------------------  -------  -----------
Subscription Name                AzureCloud   zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz  Enabled  True
```

# Helper Functions
The following details the functions available that can be real time savers.

## Account Switching

### get-accounts
Allows you to list all the subscriptions you have access to and prompts for a subscription to switch to.

Example:
`get-accounts`

## Network
### get-ips
Gets all the IP's in the subscription, or in a Resource Group if specified.

Examples:
`get-ips`
`get-ips groupname1`

### get-ips-detailed
Gets all the IP's in the subscription as well as any load balancers, or in a Resource Group if specified.

Examples:
`get-ips-details`
`get-ips-details groupname1`

## VM State
### vm-show
Show the VM's in a set of one-to-many Resource Groups

Example:
`vms-show groupname1 groupname2`

### vms-restart
Restart all VM's in a set of one-to-many Resource Groups

Example:
`vms-restart groupname1 groupname2`

### vms-start
Start all VM's in a set of one-to-many Resource Groups

Example:
`vms-start groupname1 groupname2`

### vms-stop
Stop all VM's in a set of one-to-many Resource Groups

Example:
`vms-stop groupname1 groupname2`

### vms-deallocate
Deallocate all VM's in a set of one-to-many Resource Groups

Example:
`vms-deallocate groupname1 groupname2`

## Search
### search-group
Search all resource groups in a subscription which have a name that contains the given string

`search-group test`

### search-vms
Search all virtual machines in a subscription which have a name that contains the given string

`search-vms test`

### search-vms-details
Search all virtual machines in a subscription which have a name that contains the given string, but also return the running state

`search-vms-details test`

### search-vm-from-ip
Given an IP address, get the associated VM name

Example:
`search-vm-from-ip 1.1.1.1`
