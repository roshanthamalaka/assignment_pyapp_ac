terraform {
  backend "azurerm" {
    resource_group_name  = "aks_tf_statefile" # This is created Manually to avoid complexity
    storage_account_name = "rtdevopssf"
    container_name       = "terraform"
    key                  = "terraform.tfstate"
  }
} 