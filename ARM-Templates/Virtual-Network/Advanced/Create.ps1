
$ResourceGroupName = "1-20402a82-playground-sandbox"
$VNetArgs = @{
    vnetName = "myVNet"
    location = "East US"
    vnetAddressPrefix = "10.0.0.0/16"
}

New-AzResourceGroupDeployment -Name VirtualNetwork -ResourceGroupName $ResourceGroupName @VNetArgs -TemplateFile VNet-Template.json

$SubnetArgs = @{
    subnets = @(
        @{ name = "Red"; prefix = "10.0.2.0/24" }
        @{ name = "Blue"; prefix = "10.0.3.0/24" }
        @{ name = "Green"; prefix = "10.0.4.0/24" }
    )
    location = "East US"
    vnetName = "myVNet"
}

New-AzResourceGroupDeployment -Name Subnet -ResourceGroupName $ResourceGroupName @SubnetArgs -TemplateFile Subnets-Template.json