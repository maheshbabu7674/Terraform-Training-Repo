terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0"
    }
  }
}

provider "azurerm" {
  subscription_id            = "d20ad544-b95b-410f-a838-1c48d4b7ce2a"
  client_id                  = "bf8fbf35-19b6-4478-9f41-1f32c10ab9f6"
  client_secret              = "gkn8Q~owZ8UW5n2_aCnH0AKUkwf0Gq4crEdr8aVo"
  tenant_id                  = "38ad97fe-c9d2-4004-a4ee-18b67ff396cc"
  skip_provider_registration = true
  features {}
}

resource "azurerm_resource_group" "Terraform_Training" {
  name     = "Terraform-Training-rg-01"
  location = "South India"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "storage78677"
  resource_group_name      = "Terraform-Training-rg-01"
  location                 = "South India"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_virtual_network" "terraform_network" {
  name                = "vnetwork78677"
  location            = "South India"
  resource_group_name = "Terraform-Training-rg-01"
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "terraform_subnet" {
  name                 = "subnet78677"
  resource_group_name  = "Terraform-Training-rg-01"
  virtual_network_name = "vnetwork78677"
  address_prefixes     = ["10.0.2.0/24"]
}


resource "azurerm_network_interface" "terraform_interface" {
  name                = "nicinterface78677"
  location            = "South India"
  resource_group_name = "Terraform-Training-rg-01"

  ip_configuration {
    name                          = "subnet78677"
    subnet_id                     = azurerm_subnet.terraform_subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [
    azurerm_virtual_network.terraform_network
  ]
}

resource "azurerm_windows_virtual_machine" "terraform_vm" {
  name                = "myvm78677"
  resource_group_name = "Terraform-Training-rg-01"
  location            = "South India"
  size                = "Standard_D2s_v3"
  admin_username      = "demousr"
  admin_password      = "Azure@123"
  network_interface_ids = [
    azurerm_network_interface.terraform_interface.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  depends_on = [
    azurerm_network_interface.terraform_interface
  ]
}