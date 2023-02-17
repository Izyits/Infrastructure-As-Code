terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
   backend "azurerm" {
    resource_group_name  = "Terraform_RG"
    storage_account_name = "terraformstorage"
    container_name       = "state-files"
    key                  = "GitActions.tfstate" 
  }
}
provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "rg" {
  name     = "GitActions-RG"
  location = "westus2"
}