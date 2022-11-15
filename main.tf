module "create-virtual-machine" {
    source = "./createVM"

    resource_group_name  = "terraformRG"
    location             = "eastus"
    virtual_network_name = "terraformVN"
    subnet_name          = "terraformSubnet"
    nic_name             = "terraformNIC"
    virtual_machine_name = "FirstVM"
    admin_username       = "testuser"
    address_prefixes     = ["10.0.0.0/24"]
}

module "create-virtual-machine2" {
    source = "./createVM"

    resource_group_name  = "terraformRG"
    location             = "eastus"
    virtual_network_name = "terraformVN"
    subnet_name          = "terraformSubnet"
    nic_name             = "terraformNIC"
    virtual_machine_name = "SecondVM"
    admin_username       = "testuser"
    address_prefixes     = ["10.0.0.1/24"]
}
