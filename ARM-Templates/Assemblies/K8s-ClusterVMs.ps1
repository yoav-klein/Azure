########################################
#
#   This assembly creates a virtual network, with 
#   a subnet, and 3 virtual machines - master and 2 worker nodes
#
#   The VMs have public IP addresses
#
########################################

$ResourceGroupName = "1-f90e6e66-playground-sandbox"
$SubnetArgs = @{
    vnetName = "myVNet"
    location = "eastus"
    vnetAddressPrefix = "10.0.0.0/16"
    subnets = @(
        { name = "mySubnet"; prefix = "10.0.1.0/24" }
    )
}

$MasterVM = 

New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName  @SubnetArgs -TemplateFile ../Networking/Several-Subnets/VNet-Template.json
