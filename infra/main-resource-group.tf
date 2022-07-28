resource "azurerm_resource_group" "this" {
  name     = "rg-datalake"
  location = var.location
}