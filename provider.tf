#https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_secret.html

provider "azurerm" {
subscription_id="${var.azure-sub-id}"
client_id="${var.azure-client-id}"
client_secret="${var.azure-client-secret}"
tenant_id="${var.azure-tenant-id}"
features {}
}
