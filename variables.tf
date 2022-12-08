variable "resource_group_name" {
  description = "RG name"
  type = string
  default = "terraformRG"
}

variable "location" {
  description = "RG location"
  type = string
  default = "eastus"
}

variable "virtual_network_name" {
  description = "VN name"
  type = string
  default = "terraformVN"
}

variable "subnet_name" {
  description = "Subnet name"
  type = string
  default = "terraformSubnet"
}

variable "nic_name" {
  description = "NIC name"
  type = string
  default = "terraformNIC"
}

variable "virtual_machine_name" {
  description = "VM name"
  type = string
  default = "MyVM"
}

variable "admin_username" {
  description = "Admin username"
  type = string
  default = "testuser"
}

variable "address_prefixes" {
  description = "Address prefixes"
  type = list(string)
  default = ["10.0.0.0/24"]
}

variable "nestedTest" {
  type = object({
    name    = string
    address = string
  })
  default = {
    name    = "hello"
    address = "address"
  }
}
variable "booleanTest" {
  description = "If set to true, it will create vm"
  type        = bool
  default     = false
}
