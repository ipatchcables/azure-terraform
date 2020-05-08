#https://www.terraform.io/docs/providers/azurerm/r/virtual_machine.html

resource "azurerm_managed_disk" "test2" {
name = "datadisk_existing_2"
location="${azurerm_resource_group.red_team_group.location}"
resource_group_name = "${azurerm_resource_group.red_team_group.name}"
storage_account_type = "Standard_LRS"
create_option = "Empty"
disk_size_gb = "25"
}

resource "azurerm_virtual_machine" "test2" {
  name = "C2"
  location="${azurerm_resource_group.red_team_group.location}"
  resource_group_name = "${azurerm_resource_group.red_team_group.name}"
  network_interface_ids = ["${azurerm_network_interface.NIC2.id}"]
  vm_size = "Standard_DS1_v2"
  delete_os_disk_on_termination = "true"
  delete_data_disks_on_termination = "true"

# az vm image list --all
# az vm image list --all --publisher kali
storage_image_reference {
publisher = "kali-linux"
offer = "kali-linux"
sku = "kali"
version = "2019.2.0"
}
plan {
name = "kali"
publisher = "kali-linux"
product = "kali-linux"
}
storage_os_disk {
name = "datadisk2"
caching = "ReadWrite"
create_option = "FromImage"
managed_disk_type="Standard_LRS"
}
#define credentials
os_profile {
computer_name = "C2"
admin_username = "${var.vm_user}"
admin_password = "${var.vm_pass}"
}
os_profile_linux_config {
    disable_password_authentication = false
    ssh_keys {
            path     = "/home/redteam/.ssh/authorized_keys"
            key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDmUT90f27SLK6iTumewgdBdkXB0X1TnK8WYmYMvW29fh/MBNKZGLHF05rvgE4CE7LikcehplPZlkym24tljDQU8b+/Ghuhjuiwe5+EgOmQCrN8DxVE9XvdMgrSg/HeQKBLJzMvYSMNXUfwpDbedmYCoCjBNLhXPgZNUw22uVexwsUs/aq76dxNMxvngkGjKnxtwf/UL69i3RD8FCJAChaaraokLkcDqLdMISnHtoTl9kjJ7xC8slWviP9qZ62UBTafMPAxnw3bgohdLcnSI/skoAnV6CCxUpx6x2eq+0iiNuHTNTCI83ZxuFE92Bkdt1+77zkGNqhOZTAHg5LIGBmn"
    }

    }
}
