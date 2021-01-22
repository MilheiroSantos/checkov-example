provider "azurerm" {
  version = "=2.43.0"
  features {}
}

variable "environment" {
  type = string
}

resource "azurerm_resource_group" "this" {
  name     = "${var.environment}-myrg"
  location = "West Europe"
}

resource "azurerm_storage_account" "this" {
  #checkov:skip=CKV_AZURE_33

  name                     = "mystorageaccount"
  account_replication_type = "LRS"
  account_tier             = "Premium"
  location                 = azurerm_resource_group.this.location
  resource_group_name      = azurerm_resource_group.this.name

  min_tls_version           = "TLS1_2"
  enable_https_traffic_only = true

  network_rules {
    default_action = "Deny"
    ip_rules       = ["80.0.2.0"]
  }
}
