variable "resource_group_name" {
    type        = string
    description = "Name of the resource group" 
}

variable "location" {
    type        = string
    description = "Region where to deploy resources"
}

variable "azure_container_registry_name" {
  type        = string
  default     = "oussweatherapp"
  description = "Azure Container Registry name"
}
variable "service_plan_name" {
  type        = string
  default     = "weather-web-app-sp"
  description = "App service plan name"
}

variable "os_type" {
  type        = string
  default     = "Linux"
  description = "OS type for the app service plan"
}

variable "sku_name" {
  type        = string
  default     = "B1"
  description = "SKU name for the app service plan"
}
variable "frontend_web_app_name" {
  type        = string
  default     = "weather-app-frontend"
  description = "Frontend web app name"
}
variable "backend_web_app_name" {
  type        = string
  default     = "weather-app-backend"
  description = "Backend web app name"
}

variable "apps" {
  description = "Configuration for web apps"
  type = map(object({
    docker_image_name = string
  }))
  default = {
    "weather-app-frontend" = {
      docker_image_name = "weather-app-frontend:latest"
    },
    "weather-app-backend" = {
      docker_image_name = "weather-app-backend:latest"
    }
  }
}

