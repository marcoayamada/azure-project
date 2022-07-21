resource "azurerm_mssql_server" "this" {
  name                         = "sql-server-001-${random_string.suffix.result}"
  resource_group_name          = azurerm_resource_group.this.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = random_uuid.mssql_database_administrator.result
  administrator_login_password = random_password.mssql_database_password.result
  minimum_tls_version          = "1.2"

  azuread_administrator {
    login_username = "AzureAD Admin"
    object_id = data.azurerm_client_config.current.object_id
  }
}

# resource "azurerm_mssql_database" "this" {
#   name           = "db-001"
#   server_id      = azurerm_mssql_server.example.id
#   collation      = "SQL_Latin1_General_CP1_CI_AS"
#   license_type   = "LicenseIncluded"
#   max_size_gb    = 4
#   read_scale     = true
#   sku_name       = "S0"
#   zone_redundant = true

#   tags = {
#     foo = "bar"
#   }
# }