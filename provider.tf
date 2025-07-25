terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.12.2"
}

provider "azurerm" {
  features {}
  subscription_id = "f5929557-6d14-46cb-b403-19ca764f6560"
} 