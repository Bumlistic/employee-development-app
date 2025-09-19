variable "devflow_resource_group_name" {
  type = string
  description = "This is for resource group name"
  default = "devflow-project-rg"
}
variable "devflow_location" {
  type = string
  description = "The location where the resource will be created"
  default = "Canada Central"
}

variable "devflow_mssql_server_name" {
    type = string
    description = "Name of the mssql server instance"
    default = "devflow-mssql-server"
}

variable "devflow_mssql_server_version" {
    type = string
    description = "The version of the mssql server instance"
    default = "12.0"  
}

variable "devflow_mssql_server_admin" {
    type = string
    description = "The name of the admin of the mssql server instance"
    default = "missadministrator"  
}

variable "devflow_mssql_server_password" {
    type = string
    description = "The password of the mssql server admin password"
    default = "thisIsKat11"
}

variable "devflow_mssql_server_tsl_version" {
    type = string
    description = "The tls version of the mssql server instance"
    default = "1.2"  
}

variable "devflow_tags" {
    type = map(string)
    description = "Tag of the devflow resources"
    default = {
      "Environment" = "Development"
      "Created with" = "Terraform"
    }
}

variable "devflow_mssql_server_database_name" {
    type = string
    description = "MSSQL server database name"
    default = "devflow-db"
}

variable "devflow_key_vault_name" {
    type = string
    description = "The name of devflow key vault"
    default = "bumlistivkeyvault"
}

variable "devflow_key_vault_enabled_for_disk_encryption" {
    type = bool
    description = "Flag used to enable for disk encryption of the key vault"
    default = true 
}

variable "devflow_purge_protection_enabled" {
    type = bool
    description = "Flag used to enable purge protection for key vault"
    default = false
  }

  variable "devflow_soft_delete_retention_days" {
    type = number
    description = "Soft delete retention days"
    default = 7    
  }

  variable "devflow_key_vault_sku_name" {
    type = string
    description = "key vault sku name"
    default = "standard"    
  }

  variable "devflow_key_vault_key_permissions" {
    type = list(string)
    description = "key permissions"
    default = [ "Get", "List" ]
  }

  variable "devflow_key_vault_secret_permissions" {
    type = list(string)
    description = "secret permissions"
    default = [ "Get", "List", "Set" ]
  }

  variable "subscription_id" {
    type = string
    description = "subscription id"
    default = "1641efcc-77e5-425a-826d-880ea00170e9"
  }

  variable "devflow_app_service_plan_name" {
  type = string
  description = "devflow app service plan name"
  default = "bumlistic-app-service-plan"
}
variable "devflow_app_service_name" {
  type = string
  description = "devflow app name"
  default = "bumlistic-app"
}
variable "devflow_app_service_plan_os_type" {
  type = string
  description = "devflow app service plan os type"
  default = "Windows"
}
variable "devflow_app_service_plan_sku_name" {
  type = string
  description = "devflow app service plan os type"
  default = "F1"
}

variable "devflow_mssql_server_firewall_rule_name" {
  type = string
  description = "Name of mssql server firewall rule name"
  default = "AllowAzureServices"
}

variable "devflow_mssql_server_firewall_start_ip_address" {
  type = string
  description = "mssql server start ip address"
  default = "0.0.0.0"
}

variable "devflow_mssql_server_firewall_end_ip_address" {
  type = string
  description = "mssql server end ip address"
  default = "0.0.0.0"
}
