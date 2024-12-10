# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network 
resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = var.address_space
}

# Subnets
resource "azurerm_subnet" "subnets" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value.address_prefix]
  delegation {
    name = each.value.delegation_name
    service_delegation {
      name = each.value.delegation_service_name
    }
  }
}

# # Subnet for the Frontend
# resource "azurerm_subnet" "frontend_subnet" {
#   name                 = var.frontend_subnet_name
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = var.frontend_subnet_address_space
#   delegation {
#     name = "delegation"
#     service_delegation {
#       name = "Microsoft.Web/serverFarms"
#     }
#   } 
# }

# # Subnet for the Backend
# resource "azurerm_subnet" "backend_subnet" {
#   name                 = var.backend_subnet_name
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = var.backend_subnet_address_space
#   private_endpoint_network_policies = "Disabled"
# }

# # Virtual Network Integration for the frontend
# resource "azurerm_app_service_virtual_network_swift_connection" "vnetintegrationconnection" {
#   app_service_id  = azurerm_linux_web_app.frontend_web_app.id
#   subnet_id       = azurerm_subnet.frontend_subnet.id
# }

