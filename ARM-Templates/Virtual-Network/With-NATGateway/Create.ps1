
$ResourceGroupName = "1-c1f236bc-playground-sandbox"
$VNetArgs = @{
    vnetName = "myVNet"
    location = "East US"
}

New-AzResourceGroupDeployment -Name VirtualNetwork -ResourceGroupName $ResourceGroupName @VNetArgs -TemplateFile VNet-Template.json
