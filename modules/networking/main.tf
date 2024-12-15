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

