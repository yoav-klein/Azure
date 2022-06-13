
$ResourceGroupName = "1-ab7d8dd8-playground-sandbox"
$VNetArgs = @{
    vnetName = "myVNet"
    location = "East US"
}

New-AzResourceGroupDeployment -Name VirtualNetwork -ResourceGroupName $ResourceGroupName @VNetArgs -TemplateFile VNet-Template.json
