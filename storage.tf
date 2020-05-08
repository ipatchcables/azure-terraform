resource "azurerm_storage_account" "storage_acc_red_team" {
name = "redteamstorage1"
resource_group_name = "${azurerm_resource_group.red_team_group.name}"
location = "${azurerm_resource_group.red_team_group.location}"
account_tier = "Standard"
account_replication_type = "LRS"

}
