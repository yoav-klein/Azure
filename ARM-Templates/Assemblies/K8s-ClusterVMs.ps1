########################################
#
#   This assembly creates a virtual network, with 
#   a subnet, and 3 virtual machines - master and 2 worker nodes
#
#   The VMs have public IP addresses
#
########################################

$CommonArgs = @{
    location = "eastus"
    ResourceGroupName = "1-f90e6e66-playground-sandbox"
}

$SubnetArgs = @{
    vnetName = "myVNet"
    vnetAddressPrefix = "10.0.0.0/16"
    subnets = @(
        @{ name = "mySubnet"; prefix = "10.0.1.0/24" }
    )
}

$VMsCommon = @{
    newOrExistingVNet = "existing"
    virtualNetworkName = "myVNet"
    subnet = "mySubnet"
}

$Master = @{
    vmName = "master"
    adminUserName = "yoav"
    authenticationType = "password"
    ubuntuOSVersion = "18.04-LTS"
    vmSize = "Standard_B2s"
}

$Node = @{
    vmName = "node"
    adminUserName = "yoav"
    authenticationType = "password"
    ubuntuOSVersion = "18.04-LTS"
    vmSize = "Standard_B2s"
}

New-AzResourceGroupDeployment -Name VNet @CommonArgs  @SubnetArgs -TemplateFile ../Networking/Several-Subnets/VNet-Template.json

New-AzResourceGroupDeployment -Name VirtualMachine @CommonArgs @VMsCommon @Master -TemplateFile ../Virtual-Machines/Advanced/VirtualMachine-Template.json
New-AzResourceGroupDeployment -Name VirtualMachine @CommonArgs @VMsCommon @Node -TemplateFile ../Virtual-Machines/Advanced/VirtualMachine-Template.json
