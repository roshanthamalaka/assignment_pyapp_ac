data "azurerm_subnet" "public" {
  name                 = "Public" # This subnet was created inside a resource block with using seperate block. Therefore to fetch the subnet id in other config files has to use a data source
  virtual_network_name = azurerm_virtual_network.vnet_sea.name
  resource_group_name  = azurerm_virtual_network.vnet_sea.resource_group_name
}
