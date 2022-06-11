
$ResourceGroupName = "1-2c3e846e-playground-sandbox"
$VNetArgs = @{
    vnetName = "myVNet"
    location = "East US"
}

New-AzResourceGroupDeployment -Name VirtualNetwork -ResourceGroupName $ResourceGroupName @VNetArgs -TemplateFile VNet-Template.json
