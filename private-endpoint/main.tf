# Private Endpoint for private backend 
resource "azurerm_private_dns_zone" "dns_private_zone" {
  name                = "private_link.azurewebsites.net"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_zone_link" {
  name = "dns_zone_link"
  resource_group_name = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dns_private_zone.name
  virtual_network_id = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "backend_private_endpoint"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.backend_subnet.id

  private_dns_zone_group {
    name = "private_dns_zone_group"
    private_dns_zone_ids = [azurerm_private_dns_zone.dns_private_zone.id]
  }

  private_service_connection {
    name = "private_endpoint_connection"
    private_connection_resource_id = azurerm_linux_web_app.backend_web_app.id
    subresource_names = ["sites"]
    is_manual_connection = false
  }
}