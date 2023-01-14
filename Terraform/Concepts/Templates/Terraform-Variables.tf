terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.39.0"
    }
  }
}

provider "azurerm" {
  features {}
}


variable "string-var" {
  type    = string
  default = "String-Var-RG"
}


variable "number-var" {
  type    = number
  default = 100
}

variable "list-var" {
  type    = list(any)
  default = ["LRS", "ZRS", "GRS"]
}


variable "map-var" {
  default = {
    rgname     = "Map-Var-RG"
    rglocation = "westus"
  }

}


# reference string variable
resource "azurerm_resource_group" "String-Var-Example" {
  name     = var.string-var # referencing the variable with string values
  location = "eastus"
}



# reference number variable
resource "azurerm_network_security_group" "Number-Var-Example" {
  name                = "NumberVarNSG"
  location            = "eastus"
  resource_group_name = "Example-RG"

  security_rule {
    name                       = "test123"
    priority                   = var.number-var # referencing the variable with numeric values 
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}




# reference list variable
resource "azurerm_storage_account" "example" {
  name                     = "01aexamplestorage"
  resource_group_name      = "Example-RG"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = var.list-var[0] # referencing the values from the list variable
}





# reference map variable
resource "azurerm_resource_group" "Map-Var-Example" {
  name     = var.map-var.rgname     # referencing the variable within the map type variable
  location = var.map-var.rglocation # referencing the variable within the map type variable
}



