output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.devflow_resource_group.name
}

output "sql_server_name" {
  description = "The name of the SQL Server"
  value       = azurerm_mssql_server.devflow_mssql_server.name
}

output "sql_database_name" {
  description = "The SQL Database name"
  value       = azurerm_mssql_database.devflow_mssql_server_database.name
}

output "sql_connection_string" {
  description = "Connection string for the database"
  value       = "Server=tcp:${azurerm_mssql_server.devflow_mssql_server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.devflow_mssql_server_database.name};Persist Security Info=False;User ID=${var.devflow_mssql_server_admin};Password=${var.devflow_mssql_server_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  sensitive   = true
}

output "app_service_url" {
  description = "The default hostname of the App Service"
  value       = azurerm_windows_web_app.bumlistic-web-app.default_hostname
}

output "key_vault_uri" {
  description = "The URI of the Key Vault"
  value       = azurerm_key_vault.devflow_key_vault.vault_uri
}
