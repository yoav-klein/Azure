
$Arguments = @{
    ResourceGroupName = "1-56429685-playground-sandbox"
    vnetName = "myVNet"
    location = "East US"
    subnet1Name = "Web"
    subnet2Name = "Backend"
    NSG1Name = "NSG-Web"
    NSG2Name = "NSG-Backend"
}

New-AzResourceGroupDeployment -Name VirtualNetwork @Arguments -TemplateFile VNet-Template.json