
$ResourceGroupName = "1-f90e6e66-playground-sandbox"
$Arguments = @{
    vnetName = "myVNet"
    location = "East US"
    vnetAddressPrefix = "10.0.0.0/16"
    subnets = @(
        @{ name = "mySubnet"; prefix = "10.0.1.0/24" }
        @{ name = "anotherSubnet"; prefix = "10.0.2.0/24" }
    )
}

New-AzResourceGroupDeployment -Name VirtualNetwork -ResourceGroupName $ResourceGroupName @Arguments -TemplateFile VNet-Template.json
