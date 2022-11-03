terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    tls = {
      source = "hashicorp/tls"
      version = "~>4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_resource_group" "terraformRG" {
  name = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "terraformVN" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.terraformRG.name
  location            = azurerm_resource_group.terraformRG.location
}

resource "azurerm_subnet" "terraformSubnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.terraformRG.name
  virtual_network_name = azurerm_virtual_network.terraformVN.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_network_interface" "terraformNIC" {
  name                = var.nic_name
  resource_group_name = azurerm_resource_group.terraformRG.name
  location            = azurerm_resource_group.terraformRG.location

  ip_configuration {
    name                          = "terraformIP"
    subnet_id                     = azurerm_subnet.terraformSubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "terraformVM" {
  name                = var.virtual_machine_name
  resource_group_name = azurerm_resource_group.terraformRG.name
  location            = azurerm_resource_group.terraformRG.location
  size                = "Standard_DS1_v2"
  network_interface_ids = [
    azurerm_network_interface.terraformNIC.id,
  ]
  admin_username = var.admin_username

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.example_ssh.public_key_openssh
  }
}
