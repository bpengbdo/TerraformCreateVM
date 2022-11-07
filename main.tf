module "create-virtual-machine" {
    source = "./createVM"

    resource_group_name  = "terraformRG"
    location             = "eastus"
    virtual_network_name = "terraformVN"
    subnet_name          = "terraformSubnet"
    nic_name             = "terraformNIC"
    virtual_machine_name = "FirstVM"
    admin_username       = "testuser"
}

module "create-virtual-machine2" {
    source = "./createVM"

    resource_group_name  = "terraformRG2"
    location             = "eastus"
    virtual_network_name = "terraformVN2"
    subnet_name          = "terraformSubnet2"
    nic_name             = "terraformNIC2"
    virtual_machine_name = "SecondVM"
    admin_username       = "testuser"
}
