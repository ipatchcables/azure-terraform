#Create Public IP

resource "azurerm_public_ip" "datasourceip" {
name = "testPublicIp"
location="${azurerm_resource_group.red_team_group.location}"
resource_group_name = "${azurerm_resource_group.red_team_group.name}"
allocation_method="Static"
}

resource "azurerm_public_ip" "datasourceip2" {
name = "testPublicIp2"
location="${azurerm_resource_group.red_team_group.location}"
resource_group_name = "${azurerm_resource_group.red_team_group.name}"
allocation_method="Static"
}

resource "azurerm_public_ip" "datasourceip3" {
name = "testPublicIp3"
location="${azurerm_resource_group.red_team_group.location}"
resource_group_name = "${azurerm_resource_group.red_team_group.name}"
allocation_method="Static"
}
# Create a virtual network within the resource group
resource "azurerm_virtual_network" "my_virt_net" {
name = "production-network"
address_space = ["10.0.0.0/16"]
location = "${azurerm_resource_group.red_team_group.location}"
resource_group_name = "${azurerm_resource_group.red_team_group.name}"

}

#create subnets
resource "azurerm_subnet" "test1" {
name = "subnet1"
resource_group_name = "${azurerm_resource_group.red_team_group.name}"
virtual_network_name="${azurerm_virtual_network.my_virt_net.name}"
address_prefix = "10.0.1.0/24"
}

#Create network interface

resource "azurerm_network_interface" "NIC1" {
name = "Red_Team_NIC1"
location = "${azurerm_resource_group.red_team_group.location}"
resource_group_name = "${azurerm_resource_group.red_team_group.name}"
#network_security_group_id = "${var.vm_security_group_id}"
ip_configuration {
name = "Kali"
subnet_id = "${azurerm_subnet.test1.id}"
private_ip_address_allocation = "dynamic"
public_ip_address_id = "${azurerm_public_ip.datasourceip.id}"
}
}
resource "azurerm_network_interface" "NIC2" {
name = "Red_Team_NIC2"
location = "${azurerm_resource_group.red_team_group.location}"
resource_group_name = "${azurerm_resource_group.red_team_group.name}"
#network_security_group_id = "${var.vm_security_group_id}"
ip_configuration {
name = "Kali"
subnet_id = "${azurerm_subnet.test1.id}"
private_ip_address_allocation = "dynamic"
public_ip_address_id = "${azurerm_public_ip.datasourceip2.id}"
}
}
resource "azurerm_network_interface" "NIC3" {
name = "Red_Team_NIC3"
location = "${azurerm_resource_group.red_team_group.location}"
resource_group_name = "${azurerm_resource_group.red_team_group.name}"
#network_security_group_id = "${var.vm_security_group_id}"
ip_configuration {
name = "Kali"
subnet_id = "${azurerm_subnet.test1.id}"
private_ip_address_allocation = "dynamic"
public_ip_address_id = "${azurerm_public_ip.datasourceip3.id}"
}
}
