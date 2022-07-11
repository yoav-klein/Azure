
$ResourceGroupName = "1-bab804f1-playground-sandbox"
$ControllersSubnet = @{
    vnetName = "myVNet"
    newOrExistingVnet = "New"
    location = "East US"
    vnetAddressPrefix = "10.0.0.0/16"
    newOrExistingNSG = "New"
    NSGName = "myNSG"
    subnetName = "controllersSubnet"
    subnetPrefix = "10.0.1.0/24"
    
}

$WorkersSubnet = @{
    vnetName = "myVNet"
    newOrExistingVnet = "Existing"
    location = "East US"
    newOrExistingNSG = "New"
    NSGName = "workersNSG"
    subnetName = "workersSubnet"
    subnetPrefix = "10.0.2.0/24"
    natGatewayName = "myNG"
}


New-AzResourceGroupDeployment -Name VirtualNetwork -ResourceGroupName $ResourceGroupName @ControllersSubnet -TemplateFile Subnet-Template.json
New-AzResourceGroupDeployment  -Name VirtualNetwork -ResourceGroupName $ResourceGroupName @WorkersSubnet -TemplateFile Subnet-Template.json

