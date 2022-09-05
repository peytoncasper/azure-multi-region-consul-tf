provider "azurerm" {
  features {}
}

module "certs" {
  source = "./certs"
}


resource "azurerm_resource_group" "consul_east" {
  name     = "consul-east"
  location = "East US"
}

resource "azurerm_resource_group" "consul_west" {
  name     = "consul-west"
  location = "West US"
}


module "network_east" {
  source  = "./network"

  resource_group = azurerm_resource_group.consul_east.name


  depends_on = [
    azurerm_resource_group.consul_east,
    module.certs
  ]
}

module "network_west" {
  source  = "./network"

  resource_group = azurerm_resource_group.consul_west.name

  depends_on = [
    azurerm_resource_group.consul_west,
    module.certs
  ]
}


module "azure_east" {
  source  = "./consul/azure"

  resource_group = azurerm_resource_group.consul_east.name

  virtual_network_name = module.network_east.azure_virtual_network_name

  datacenter = "azure-east"
  primary_datacenter = "azure-east"

  depends_on = [
    module.network_east,
  ]
}

module "azure_west" {
  source  = "./consul/azure"
  
  bootstrap_ip = module.azure_east.consul_ip

  resource_group = azurerm_resource_group.consul_west.name

  virtual_network_name = module.network_west.azure_virtual_network_name

  datacenter = "azure-west"
  primary_datacenter = "azure-east"

  depends_on = [
    module.network_west,
    module.azure_east
  ]
}