terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "Terrafrom-RG"
    storage_account_name = "terraformstorage"
    container_name       = "tfstatefiles"
    key                  = "terraform-remote-state.tfstate"     # can be named anything with tfstate extension
  }
}


provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "Remote-State-RG" {
  name     = "Remote-State-RG"
  location = "westus2"
}