module "virtual_network" {
  source              = "./networking"
  name                = "weather-app-net"
  resource_group_name = "weather-app-rg"
  location            = "West Europe"
  address_space       = ["10.0.0.0/16"]
  subnets = {
    "frontend-subnet" = {
      address_prefix        = "10.0.1.0/24"
      delegation_name       = "delegation"
      delegation_service_name = "Microsoft.Web/serverFarms"
    },
    "backend-subnet" = {
      address_prefix        = "10.0.2.0/24"
      delegation_name       = "delegation"
      delegation_service_name = "Microsoft.Web/serverFarms"
    }
  }
}

module "app_services" {
  source               = "./app-services"
  service_plan_name    = "weather-web-app-sp"
  location             = module.virtual_network.resource_group_location
  resource_group_name  = module.virtual_network.resource_group_name
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
