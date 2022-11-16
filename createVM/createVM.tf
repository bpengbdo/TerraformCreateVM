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

resource "azurerm_subnet" "terraformSubnet" {
  for_each             = toset(var.vm_name)
  name                 = each.value
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
}

resource "azurerm_network_interface" "terraformNIC" {
  for_each            = toset(var.vm_name)
  name                = each.value
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "terraformIP"
    subnet_id                     = azurerm_subnet.terraformSubnet[each.value].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "terraformVM" {
  for_each            = toset(var.vm_name)
  name                = each.value
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_DS1_v2"
  network_interface_ids = [
    azurerm_network_interface.terraformNIC[each.value].id,
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
