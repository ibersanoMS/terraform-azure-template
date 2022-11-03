# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.27.0"
    }
  }
  required_version = ">= 0.14.9"

  backend "azurerm" {
  }
}
provider "azurerm" {
  features {}
}