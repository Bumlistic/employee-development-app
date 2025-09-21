output "devflow_app_service_name" {
  description = "The name of the App Service"
  value       = azurerm_windows_web_app.webapp.name
}

output "devflow_db_connection_string" {
  description = "SQL Server connection string"
  value       = azurerm_key_vault_secret.db_conn_string.value
  sensitive   = true
}

output "devflow_resource_group_name" {
  description = "Resource Group name"
  value       = azurerm_resource_group.rg.name
}

output "devflow_mssql_server_fqdn" {
  description = "SQL Server FQDN"
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}

output "devflow_database_name" {
  description = "Database name"
  value       = azurerm_mssql_database.db.name
}

output "devflow_key_vault_uri" {
  description = "Key Vault URI"
  value       = azurerm_key_vault.kv.vault_uri
}
