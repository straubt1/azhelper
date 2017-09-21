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
`docker run -it -v ${HOME}/.azure:/root/.azure straubt1/azhelper`

### Run on Windows
`docker run -it -v /${HOME}/.azure:/root/.azure straubt1/azhelper`
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
