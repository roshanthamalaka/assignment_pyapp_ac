## Virtual Machine to Install Prometheus Server

# Create Public IP Address to SSH 
resource "azurerm_public_ip" "promvm_pub_ip" {
  name                = "${var.vmname}-pubip"
  resource_group_name = azurerm_resource_group.devops_project.name
  location            = azurerm_resource_group.devops_project.location
  allocation_method   = "Static"
  depends_on          = [azurerm_resource_group.devops_project]
}

#Create Network Security Group
resource "azurerm_network_security_group" "nsg_provmnic" {
  name                = "${var.vmname}-nic-nsg"
  location            = azurerm_resource_group.devops_project.location
  resource_group_name = azurerm_resource_group.devops_project.name
  depends_on          = [azurerm_resource_group.devops_project]
}

#Create Security Group Rule to Allow SSH from all. This is security risk. But since this is test service added like this. For Prod deployment restric this to specifc ip and use customized port 
resource "azurerm_network_security_rule" "rule1_inbound" {
  name                        = "SSH_From_All"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.devops_project.name
  network_security_group_name = azurerm_network_security_group.nsg_provmnic.name
  depends_on                  = [azurerm_network_security_group.nsg_provmnic]
}

resource "azurerm_network_security_rule" "rule2_inbound" {
  name                        = "Allow_promethus_traffic_9090"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "9090"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.devops_project.name
  network_security_group_name = azurerm_network_security_group.nsg_provmnic.name
  depends_on                  = [azurerm_network_security_group.nsg_provmnic]
}



# Allow All Outbound Traffic
resource "azurerm_network_security_rule" "rule1_outbound" {
  name                        = "Allow_outbound"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.devops_project.name
  network_security_group_name = azurerm_network_security_group.nsg_provmnic.name
  depends_on                  = [azurerm_network_security_group.nsg_provmnic]
}




# Create NIC and Associate it with Public IP 
resource "azurerm_network_interface" "promvm_nic" {
  name                = "${var.vmname}-nic"
  location            = azurerm_resource_group.devops_project.location
  resource_group_name = azurerm_resource_group.devops_project.name

  ip_configuration {
    name                          = "main"
    subnet_id                     = data.azurerm_subnet.public.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "172.16.1.10"
    public_ip_address_id          = azurerm_public_ip.promvm_pub_ip.id
  }

  depends_on = [azurerm_resource_group.devops_project, azurerm_virtual_network.vnet_sea, azurerm_public_ip.promvm_pub_ip]
}

#Associate NSG with Network Interface Card
resource "azurerm_network_interface_security_group_association" "promvm_nic" {
  network_interface_id      = azurerm_network_interface.promvm_nic.id
  network_security_group_id = azurerm_network_security_group.nsg_provmnic.id
  depends_on                = [azurerm_network_security_group.nsg_provmnic, azurerm_network_interface.promvm_nic]
}



# Create Promethues VM
resource "azurerm_virtual_machine" "promvm" {
  name                  = var.vmname
  location              = azurerm_resource_group.devops_project.location
  resource_group_name   = azurerm_resource_group.devops_project.name
  network_interface_ids = [azurerm_network_interface.promvm_nic.id]
  vm_size               = "Standard_B1s"



  storage_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.vmname}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "roshan"
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/roshan/.ssh/authorized_keys" ## Copy Public from my Local Machine to the Prometheus VM
      key_data = file("~/.ssh/id_rsa.pub")
    }

  }

  depends_on = [azurerm_network_interface.promvm_nic]
}