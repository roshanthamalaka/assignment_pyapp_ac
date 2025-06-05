#Create Azure Kubernetes Cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "devops_aks_demo"
  location            = azurerm_resource_group.devops_project.location
  resource_group_name = azurerm_resource_group.devops_project.name
  dns_prefix          = "rtmyapp"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_A2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true
  sku_tier = "Free" 

  node_os_upgrade_channel = "None"

  network_profile {
        network_plugin = "azure"
        network_policy = "azure"
  }
  azure_policy_enabled = false

    depends_on = [ azurerm_resource_group.devops_project ]
}
