variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
  default     = "1641efcc-77e5-425a-826d-880ea00170e9"
}

variable "devflow_resource_group_name" {
  type        = string
  description = "Resource group name"
  default     = "devflow-project-rg"
}

variable "devflow_location" {
  type        = string
  description = "Azure location"
  default     = "Canada Central"
}

variable "devflow_tags" {
  type = map(string)
  default = {
    Environment  = "Development"
    "Created with" = "Terraform"
  }
}

variable "devflow_mssql_server_name" {
  type    = string
  default = "devflow-mssql-server"
}

variable "devflow_mssql_server_version" {
  type    = string
  default = "12.0"
}

variable "devflow_mssql_server_admin" {
  type    = string
  default = "missadministrator"
}

variable "devflow_mssql_server_password" {
  type    = string
  default = "thisIsKat11"
}

variable "devflow_mssql_server_tsl_version" {
  type    = string
  default = "1.2"
}

variable "devflow_mssql_server_database_name" {
  type    = string
  default = "devflow-db"
}

variable "devflow_mssql_server_firewall_rule_name" {
  type    = string
  default = "AllowAzureServices"
}

variable "devflow_mssql_server_firewall_start_ip_address" {
  type    = string
  default = "0.0.0.0"
}

variable "devflow_mssql_server_firewall_end_ip_address" {
  type    = string
  default = "0.0.0.0"
}

variable "devflow_key_vault_name" {
  type    = string
  default = "bumlistivkeyvault"
}

variable "devflow_key_vault_enabled_for_disk_encryption" {
  type    = bool
  default = true
}

variable "devflow_purge_protection_enabled" {
  type    = bool
  default = false
}

variable "devflow_soft_delete_retention_days" {
  type    = number
  default = 7
}

variable "devflow_key_vault_sku_name" {
  type    = string
  default = "standard"
}

variable "devflow_key_vault_key_permissions" {
  type    = list(string)
  default = ["Get", "List"]
}

variable "devflow_key_vault_secret_permissions" {
  type    = list(string)
  default = ["Get", "List", "Set"]
}

variable "devflow_app_service_plan_name" {
  type    = string
  default = "bumlistic-app-service-plan"
}

variable "devflow_app_service_name" {
  type    = string
  default = "bumlistic-app"
}

variable "devflow_app_service_plan_os_type" {
  type    = string
  default = "Windows"
}

variable "devflow_app_service_plan_sku_name" {
  type    = string
  default = "F1"
}
