
$CommonArguments = @{
    ResourceGroupName = "1-17f5695d-playground-sandbox"
    location = "East US"
    newOrExistingVNet = "existing"
    virtualNetworkName = "myVNet"
    subnetName = "mySubnet"
    #"networkSecurityGroupName" = "myNSG" # not needed when using existing vnet
}

# Frontend vm
$FEVM = @{
    vmName = "FrontEnd-VM"
    adminUserName = "yoav"
    authenticationType = "password"
    ubuntuOSVersion = "18.04-LTS"
    vmSize = "Standard_B2s"
}

# Backend vm
$BEVM = @{
    vmName = "BackEnd-VM"
    adminUserName = "yoav"
    authenticationType = "password"
    ubuntuOSVersion = "18.04-LTS"
    vmSize = "Standard_B2s"
}

New-AzResourceGroupDeployment -Name VirtualMachine @CommonArguments @FEVM -TemplateFile VirtualMachine-Template.json
New-AzResourceGroupDeployment -Name VirtualMachine @CommonArguments @BEVM -TemplateFile VirtualMachine-Template.json