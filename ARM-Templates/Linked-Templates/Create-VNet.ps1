
$Arguments = @{
    ResourceGroupName = "1-5da69676-playground-sandbox"
    vnetName = "myVNet"
    location = "East US"
}

New-AzResourceGroupDeployment -Name VirtualNetwork @Arguments -TemplateFile VNet-Template.json