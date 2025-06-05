# Create a resource group
resource "azurerm_resource_group" "devops_project" {
  name     = "devOps_project_rg"
  location = "Southeast Asia"
}