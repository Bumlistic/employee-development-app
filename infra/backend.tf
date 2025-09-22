terraform {
  backend "azurerm" {
    resource_group_name  = var.devflow_storage_resource_group_name
    storage_account_name = var.devflow_storage_account_name
    container_name       = var.devflow_container_name
    key                   = var.devflow_state_key
    use_azuread_auth      = true
  }
}
