module "resource_group" {
  source = "./modules/resource-group"
  name = "weather-app-rg"
  location = var.location
}

module "virtual_network" {
  source              = "./modules/networking"
  name                = "weather-app-net"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
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
