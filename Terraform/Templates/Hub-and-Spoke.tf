terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
}
provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "Hub-Spoke-RG" {
  name     = "Hub-Spoke-RG"
  location = "West Europe"
}

resource "azurerm_virtual_network" "Hub-Vnet" {
  name                = "Hub-Vnet"
  location            = azurerm_resource_group.Hub-Spoke-RG.location
  resource_group_name = azurerm_resource_group.Hub-Spoke-RG.name
  address_space       = ["10.1.0.0/16"]
  dns_servers         = ["10.1.0.4", "10.1.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.1.1.0/24"
  }
}

resource "azurerm_virtual_network" "Spoke" {
  count = 3
  name                = "${azurerm_virtual_network.Hub-Vnet.name}-spoke-${count.index}"
  location            = azurerm_resource_group.Hub-Spoke-RG.location
  resource_group_name = azurerm_resource_group.Hub-Spoke-RG.name
  address_space       = ["10.${count.index+2}.0.0/16"]
  dns_servers         = ["10.${count.index+2}.0.4", "10.${count.index+2}.0.5"]


  subnet {
    name           = "subnet1"
    address_prefix = "10.${count.index+2}.1.0/24"
  }
}