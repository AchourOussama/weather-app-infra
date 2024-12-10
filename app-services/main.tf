# Azure Container Registry

resource "azurerm_container_registry" "acr" {
  name                = var.azure_container_registry_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"
  admin_enabled       = true
}

## App Service Plan

resource "azurerm_service_plan" "appserviceplan" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.os_type
  sku_name            = var.sku_name
}

## Web applications
resource "azurerm_linux_web_app" "web_app" {
  for_each = var.apps

  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.appserviceplan.id

  site_config {
    application_stack {
      docker_registry_url    = "https://${azurerm_container_registry.acr.login_server}"
      docker_registry_username   = azurerm_container_registry.acr.admin_username
      docker_registry_password = azurerm_container_registry.acr.admin_password
      docker_image_name        = each.value.docker_image_name
    }
  }

  identity {
    type = "SystemAssigned"
  }
}