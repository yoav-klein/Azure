########################################
#
#   Kubernetes The Hard Way
#
#
#   This assembly contains infrastructure required for the Kubernetes the Hard Way course
#   It creates the following resources:
#   * Virtual network
#   * NAT Gateway
#   * 2 Subnets, for each:
#       * Network Security Group
#     
#
########################################

$NATGatewayName = "kthw-NG"
$CommonArgs = @{
    location = "eastus"
    ResourceGroupName = "1-bab804f1-playground-sandbox"
}

$VnetArgs = @{
    vnetName = "kthw-vnet"
    vnetAddressPrefix = "10.0.0.0/16"
}


$ControllersSubnet = @{
    newOrExistingVnet = "New"
    newOrExistingNSG = "New"
    NSGName = "controllersNsg"
    subnetName = "controllersSubnet"
    subnetPrefix = "10.0.1.0/24"
    natGatewayName = $NATGatewayName
    
}

$WorkersSubnet = @{
    newOrExistingVnet = "Existing"
    newOrExistingNSG = "New"
    NSGName = "workersNsg"
    subnetName = "workersSubnet"
    subnetPrefix = "10.0.2.0/24"
    natGatewayName = $NATGatewayName
}

New-AzResourceGroupDeployment  -Name NATGateway         @CommonArgs -natGatewayName $NATGatewayName -TemplateFile ../Networking/NAT-Gateway/NATGateway-Template.json
New-AzResourceGroupDeployment  -Name ControllersSubnet  @CommonArgs @VnetArgs @ControllersSubnet -TemplateFile ../Networking/Subnet/Subnet-Template.json
New-AzResourceGroupDeployment  -Name WorkersSubnet      @CommonArgs @VnetArgs @WorkersSubnet     -TemplateFile ../Networking/Subnet/Subnet-Template.json