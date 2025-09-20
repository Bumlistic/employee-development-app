# ----------------------------
# Output Safe Infrastructure Info
# ----------------------------

# Web App name (used in GitHub Actions deploy step)
output "devflow_app_service_name" {
  description = "The name of the App Service"
  value       = azurerm_windows_web_app.bumlistic-web-app.name
}

# Resource Group
output "devflow_resource_group_name" {
  description = "Resource Group name"
  value       = azurerm_resource_group.devflow_resource_group.name
}

# SQL Server FQDN (used in troubleshooting / firewall rules)
output "devflow_mssql_server_fqdn" {
  description = "Fully qualified domain name of the SQL Server"
  value       = azurerm_mssql_server.devflow_mssql_server.fully_qualified_domain_name
}

# Database name
output "devflow_database_name" {
  description = "Name of the MSSQL database"
  value       = azurerm_mssql_database.devflow_mssql_server_database.name
}

# Key Vault URI (needed for app service Key Vault references)
output "devflow_key_vault_uri" {
  description = "The URI of the Key Vault"
  value       = azurerm_key_vault.devflow_key_vault.vault_uri
}

output "devflow_db_connection_string" {
  description = "SQL Server connection string for EF Core"
  value       = azurerm_key_vault_secret.db_connection_string.value
  sensitive   = true
}
