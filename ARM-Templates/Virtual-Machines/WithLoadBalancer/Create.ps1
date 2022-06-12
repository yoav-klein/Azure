
$Arguments = @{
    ResourceGroupName = "1-d27fc885-playground-sandbox"
    location = "eastus"
    vmName = "server1"
    loadBalancerName = "myLB"
    lbBackendPoolName = "lbBackendPool"
    virtualNetworkName = "myVNet"
    subnetName = "mySubnet"
}


New-AzResourceGroupDeployment -Name VirtualMachine @Arguments -TemplateFile VirtualMachine-Template.json