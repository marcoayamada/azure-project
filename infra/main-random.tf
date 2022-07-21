resource "random_string" "suffix" {
  length           = 5
  special          = false
  upper            = false
}

# Be careful with this. Sensitive data will be stored
# as plain text in local state.
# https://www.terraform.io/language/state/sensitive-
resource "random_password" "mssql_database_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_uuid" "mssql_database_administrator" {}