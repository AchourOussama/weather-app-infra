terraform {
  backend "azurerm" {
    resource_group_name   = "DefaultResourceGroup-CCAN"
    storage_account_name  = "weatherappbackend"
    container_name        = "weather-app-tfstate"
    key                   = "terraform.tfstate"
  }
}
