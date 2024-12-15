module "resource_group" {
  source = "./modules/resource-group"
  name = "weather-app-rg"
  location = var.location
}

module "app_services" {
  source               = "./modules/app-services"
  service_plan_name    = "weather-web-app-sp"
  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location
  os_type              = "Linux"
  sku_name             = "B1"
  apps = {
    "weather-app-frontend" = {
      docker_image_name = "weather-app-frontend:latest"
    },
    "weather-app-backend" = {
      docker_image_name = "weather-app-backend:latest"
    }
  }
}

resource "azurerm_storage_account" "test" {
  name                     = "test-pipeline"
  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}