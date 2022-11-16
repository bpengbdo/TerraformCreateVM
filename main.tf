module "create-virtual-machine" {
    source = "./createVM"

    resource_group_name  = "terraformRG"
    location             = "eastus"
    virtual_network_name = "terraformVN"
    subnet_name          = "terraformSubnet"
    vm_name              = ["FirstVM", "SecondVM"]
    admin_username       = "testuser"
    address_prefixes     = ["10.0.1.0/24"]
}
