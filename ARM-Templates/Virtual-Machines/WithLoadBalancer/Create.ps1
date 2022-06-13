
$Arguments = @{
    ResourceGroupName = "1-ab7d8dd8-playground-sandbox"
    location = "eastus"
    vmName = "node1"
    loadBalancerName = "myLB"
    lbBackendPoolName = "lbBackendPool"
    virtualNetworkName = "myVNet"
    subnetName = "mySubnet"
}


New-AzResourceGroupDeployment -Name VirtualMachine @Arguments -TemplateFile VirtualMachine-Template.json