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
  name                     = "mystorageaccount"
  account_replication_type = "LRS"
  account_tier             = "Premium"
  location                 = azurerm_resource_group.this.location
  resource_group_name      = azurerm_resource_group.this.name
}
