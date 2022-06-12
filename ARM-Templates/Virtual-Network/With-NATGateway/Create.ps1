
$ResourceGroupName = "1-d27fc885-playground-sandbox"
$VNetArgs = @{
    vnetName = "myVNet"
    location = "East US"
}

New-AzResourceGroupDeployment -Name VirtualNetwork -ResourceGroupName $ResourceGroupName @VNetArgs -TemplateFile VNet-Template.json
