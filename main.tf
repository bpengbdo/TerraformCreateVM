module "create-virtual-machine" {
    source = "./createVM"
    
    resource_group_name  = var.resource_group_name
    location             = var.location
    virtual_network_name = var.virtual_network_name
    subnet_name          = var.subnet_name
    nic_name             = var.nic_name
    virtual_machine_name = var.nestedTest.name  # var.virtual_machine_name
    admin_username       = var.admin_username
    address_prefixes     = var.address_prefixes
    
}
