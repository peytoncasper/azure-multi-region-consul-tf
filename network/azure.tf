data "azurerm_resource_group" "consul" {
  name = var.resource_group
}

resource "azurerm_virtual_network" "consul" {
  name                = "consul-network"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.consul.location
  resource_group_name = data.azurerm_resource_group.consul.name
}

resource "azurerm_subnet" "consul" {
  name                 = "consul-subnet"
  resource_group_name  = data.azurerm_resource_group.consul.name
  virtual_network_name = azurerm_virtual_network.consul.name
  address_prefixes       = ["10.0.2.0/24"]

  service_endpoints = ["Microsoft.Web"]
}