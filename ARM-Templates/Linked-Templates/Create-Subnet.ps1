
$Arguments = @{
    ResourceGroupName = "1-5da69676-playground-sandbox"
    subnetName = "mySubnet"
    location = "East US"
    vnetName = "myVNet"
}

New-AzResourceGroupDeployment -Name Subnet @Arguments -TemplateFile Subnets-Template.json