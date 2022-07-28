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

resource "azurerm_mssql_firewall_rule" "this" {
  name             = "PersonalPublicIp"
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = "${chomp(data.http.myip.body)}"
  end_ip_address   = "${chomp(data.http.myip.body)}"
}

resource "azurerm_mssql_database" "this" {
  name           = "db-example-001"
  server_id      = azurerm_mssql_server.this.id
  sku_name       = "Basic"
}