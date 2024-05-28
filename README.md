# Automated ISE Virtual Network(VNET) setup using Terraform on Azure

This project runs terraform module to setup ISE VNET infrastructure on Azure

## Requirements
- Terraform ~> 1.5.x
- Azure CLI
- Azure subscription with at least `Contributor` level access

## Installations

1. To install terraform, follow the instructions as per your operating system - [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli)

2. To install Azure CLI, follow the instructions mentioned here - [Install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)


## Configuring and Authenticating using Azure CLI

To configure and allow access to Azure account, we need a user having atleast `Contributor` level access . Run the below command to get Azure access using CLI. It will prompt you to login through web browser
```
az login
```

In case you are running this command on a server where you don't have any browser you can run the below command and use the code to login on any other machine.
```
az login --use-device-code
```

To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code to authenticate.

`NOTE:` Please refer Terraform documentation for other authentication methods. -  https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs


## Prerequisites
Before running terraform modules, follow below steps

1. Setup SSH for git, follow this documentation - [How to setup SSH for git](https://www.warp.dev/terminus/git-clone-ssh) 
2. As per Terraform's best practice, it is recommended to store the state file remotely in cloud. As Storing terraform state files in storage account provides enhanced collaboration, security and durability over keeping state files locally.
- If you have a Azure storage account already created to store the state file, that needs to be referenced in terraform init command. 
- If you do not have an existing storage account then please create Azure storage account configuration which needs to be referenced in terraform init command.

Run below commands to configure storage account
```
az group create --name myResourceGroup --location eastus

az storage account create --name mystorageaccount --resource-group myResourceGroup --location eastus --sku Standard_LRS

az storage account show-connection-string --name mystorageaccount --resource-group myResourceGroup --query connectionString --output tsv

az storage container create --name mycontainer --connection-string "<your_connection_string>"
```

## Run terraform modules

Clone this git repo by using below this command 
  ```
  git clone https://github3.cisco.com/techops-operation/ise_launch_template-terraform-azure-vnet.git
  ```

Please refer Below "Inputs" section and update the terraform.tfvars as per requirement. 
Once updated, run below commands to deploy the VNET stack
```
terraform init --upgrade \
-backend-config="resource_group_name=<resource_group_name>" \
-backend-config="container_name=<container_name>" \
-backend-config="storage_account_name=<storage_account_name>" \
-reconfigure

terraform plan

terraform apply
```

Type 'yes' when prompted after running terraform apply

This deployment takes approx 10 minutes to deploy.



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ise_func_subnet"></a> [ise\_func\_subnet](#input\_ise\_func\_subnet) | Mention the subnet name for Function App VNET integration, it is a service dedicated subnet delegated to service Microsoft.Web/serverFarms. | `string` | `"ise_func_subnet"` |
| <a name="input_ise_func_subnet_cidr"></a> [ise\_func\_subnet\_cidr](#input\_ise\_func\_subnet\_cidr) | List of CIDR block for Funcation App private subnet | `list(string)` | <pre>[<br>  "10.0.14.0/26"<br>]</pre> |
| <a name="input_ise_resource_group"></a> [ise\_resource\_group](#input\_ise\_resource\_group) | Mention the Resource Group name | `string` | `"Cisco_ISE_RG"` |
| <a name="input_location"></a> [location](#input\_location) | Mention the region where you want to deploy resources | `string` | `"East US"` |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | List of CIDR blocks for private subnets | `list(string)` | <pre>[<br>  "10.0.11.0/24",<br>  "10.0.12.0/24",<br>  "10.0.13.0/24"<br>]</pre> |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | List of CIDR blocks for public subnets | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24",<br>  "10.0.3.0/24"<br>]</pre> |
| <a name="input_subscription"></a> [subscription](#input\_subscription) | Enter the Azure subscription ID | `string` | `"a8b4411b-d161-41bf-82f5-7d80b0f9aa35"` |
| <a name="input_vnet_address"></a> [vnet\_address](#input\_vnet\_address) | Enter the Virtual Network CIDR | `string` | `"10.0.0.0/16"` |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Enter the name of VNET | `string` | `"ise_vnet"` |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ise_func_subnet"></a> [ise\_func\_subnet](#output\_ise\_func\_subnet) | Function App VNET Integration Subnet CIDR |
| <a name="output_ise_func_subnet_name"></a> [ise\_func\_subnet\_name](#output\_ise\_func\_subnet\_name) | Function App VNET Integration Subnet |
| <a name="output_ise_lb_subnet_name"></a> [ise\_lb\_subnet\_name](#output\_ise\_lb\_subnet\_name) | ISE Loadbalancer Subnet |
| <a name="output_ise_vm_subnet_name"></a> [ise\_vm\_subnet\_name](#output\_ise\_vm\_subnet\_name) | ISE VM subnet |
| <a name="output_private_nsg_ids"></a> [private\_nsg\_ids](#output\_private\_nsg\_ids) | NAT Gateway ID |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | Private Subnet ID |
| <a name="output_public_ip_ids"></a> [public\_ip\_ids](#output\_public\_ip\_ids) | Public IP ID |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | Public Subnet ID |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | Resource Group |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | VNET name |

## Destroy Infrastructure

To destroy the ISE infrastructure resources created by this module, run below commands.

`NOTE:`
Manual changes/resource creation outside this terrform module will not be tracked in the terraform state and cause issues if user needs to upgrade/destory the deployed stack. Please avoid manual changes. 
If still manual changes are needed then please keep a note of changes, revert them before making any upgrade or destroy.

```
terraform destroy -plan
terraform destroy
``` 
To know more about the destroy command, please refer this [terraform destroy](https://developer.hashicorp.com/terraform/cli/commands/destroy) page

If you encounter issues with the `terraform destroy` command, attempt to run the command again. Additionally, you can track the resources managed by Terraform using the following command

```
terraform state list
```