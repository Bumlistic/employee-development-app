data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = var.devflow_resource_group_name
  location = var.devflow_location
  tags     = var.devflow_tags
}

resource "azurerm_mssql_server" "sql_server" {
  name                         = var.devflow_mssql_server_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = var.devflow_mssql_server_version
  administrator_login          = var.devflow_mssql_server_admin
  administrator_login_password = var.devflow_mssql_server_password
  minimum_tls_version          = var.devflow_mssql_server_tsl_version
  tags                         = var.devflow_tags
}

resource "azurerm_mssql_database" "db" {
  name      = var.devflow_mssql_server_database_name
  server_id = azurerm_mssql_server.sql_server.id
  tags      = var.devflow_tags
}

resource "azurerm_mssql_firewall_rule" "allow_azure" {
  server_id        = azurerm_mssql_server.sql_server.id
  name             = var.devflow_mssql_server_firewall_rule_name
  start_ip_address = var.devflow_mssql_server_firewall_start_ip_address
  end_ip_address   = var.devflow_mssql_server_firewall_end_ip_address
}

resource "azurerm_key_vault" "kv" {
  name                        = var.devflow_key_vault_name
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = var.devflow_key_vault_sku_name
  soft_delete_retention_days  = var.devflow_soft_delete_retention_days
  purge_protection_enabled    = var.devflow_purge_protection_enabled
  enabled_for_disk_encryption = var.devflow_key_vault_enabled_for_disk_encryption
}

resource "azurerm_key_vault_secret" "db_conn_string" {
  name         = "DbConnectionString"
  value        = "Server=tcp:${azurerm_mssql_server.sql_server.name}.database.windows.net,1433;Initial Catalog=${azurerm_mssql_database.db.name};Persist Security Info=False;User ID=${var.devflow_mssql_server_admin};Password=${var.devflow_mssql_server_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_service_plan" "asp" {
  name                = var.devflow_app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = var.devflow_app_service_plan_os_type
  sku_name            = var.devflow_app_service_plan_sku_name
}

resource "azurerm_windows_web_app" "webapp" {
  name                = var.devflow_app_service_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.asp.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on = false
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE"                = "1"
    "ASPNETCORE_ENVIRONMENT"                  = "Production"
    "KeyVaultUrl"                             = azurerm_key_vault.kv.vault_uri
    "ConnectionStrings__DefaultConnection"   = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.db_conn_string.id})"
  }
}

resource "azurerm_key_vault_access_policy" "webapp_policy" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_windows_web_app.webapp.identity[0].principal_id
  key_permissions    = var.devflow_key_vault_key_permissions
  secret_permissions = var.devflow_key_vault_secret_permissions

  depends_on = [azurerm_windows_web_app.webapp]
}
