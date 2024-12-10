variable "location" {
    type        = string
    default     = "West Europe"
    description = "Region where to deploy resources"
  
}

variable "resource_group_name" {
    type        = string
    default     = "weather-app-rg"
    description = "Name of the resource group"
  
}

variable "name" {
    type        = string
    default     = "weather-app-net"
    description = "Virtual network name"
}


variable "address_space" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "Address space for the virtual network"
}


variable "subnets" {
  description = "Subnets for the virtual network"
  type = map(object({
    address_prefix        = string
    delegation_name       = string
    delegation_service_name = string
  }))
  default = {
    "frontend-subnet" = {
      address_prefix        = "10.0.1.0/24"
      delegation_name       = "delegation"
      delegation_service_name = "Microsoft.Web/serverFarms"
    },
    "backend-subnet" = {
      address_prefix        = "10.0.2.0/24"
      delegation_name       = "delegation"
      delegation_service_name = ""
    }
  }
}

# variable "frontend_subnet_name" {
#     type        = string
#     default     = "frontend-subnet"
#     description = "Frontend subnet name"
# }


# variable "frontend_subnet_address_space" {
#   type        = list(string)
#   default     = ["10.0.1.0/24"]
#   description = "Address space for the frontend subnet "
# }

# variable "backend_subnet_name" {
#     type        = string
#     default     = "backend-subnet"
#     description = "Backend network name"
# }
