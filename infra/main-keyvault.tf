resource "azurerm_key_vault" "this" {
  name                        = "kv-datalake-${random_string.suffix.result}"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.this.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  sku_name = "standard"

  access_policy {
    # putting myself in access policy
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "List",
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]
  }
}

resource "azurerm_key_vault_secret" "administrator_mssql" {
  name         = "azure-sql-admin-user"
  value        = random_uuid.mssql_database_administrator.result
  key_vault_id = azurerm_key_vault.this.id
}

resource "azurerm_key_vault_secret" "secret_mssql" {
  name         = "azure-sql-admin-password"
  value        = random_password.mssql_database_password.result
  key_vault_id = azurerm_key_vault.this.id
}