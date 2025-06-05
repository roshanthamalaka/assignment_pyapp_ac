resource "azurerm_virtual_network" "vnet_sea" {
  name = "devops_vnet"
  location = azurerm_resource_group.devops_project.location
  resource_group_name = azurerm_resource_group.devops_project.name
  address_space = ["172.16.0.0/16"]

    subnet {
        name = "Public"
        address_prefixes = ["172.16.1.0/24"]

    }

  depends_on = [ azurerm_resource_group.devops_project ]
}