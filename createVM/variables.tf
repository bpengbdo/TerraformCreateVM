variable "resource_group_name" {
  description = "RG name"
  type = string
  default = ""
}

variable "location" {
  description = "RG location"
  type = string
  default = "eastus"
}

variable "virtual_network_name" {
  description = "VN name"
  type = string
  default = ""
}

variable "subnet_name" {
  description = "Subnet name"
  type = string
  default = ""
}

variable "nic_name" {
  description = "NIC name"
  type = string
  default = ""
}

variable "virtual_machine_name" {
  description = "VM name"
  type = string
  default = ""
}

variable "admin_username" {
  description = "Admin username"
  type = string
  default = ""
}

variable "address_prefixes" {
  description = "Address prefixes"
  type = list
  default = []
}
