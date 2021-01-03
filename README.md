Azure_Terraform_Windows Server 2019_IIS

Terraform scripts create two virtual machines, load balancer, VPC, subnet, etc.
Each virtual machine has its own external ip.
Returns IP addresses of virtual machines and load balancer.

In provider.tf you can see required version terraform and provider for Azure.

For install and configure IIS you shoud add ip each of virtual machine in script\winrm.ps1 .

Create terraform.tfvars file with filled variables:

subscription_id = ""
client_id       = ""
client_secret   = ""
tenant_id       = ""
location        = "West Europe"
admin_username  = ""
admin_password  = ""