terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.13.0"
    }
  }
}
provider "azurerm" {
  features {}
  # subscription_id = var.subscription_id
  client_id       = var.AZURE_CLIENT_ID
  client_secret   = var.AZURE_CLIENT_SECRET
  tenant_id       = var.AZURE_TENANT_ID
  subscription_id = var.AZURE_SUBSCRIPTION_ID
}
