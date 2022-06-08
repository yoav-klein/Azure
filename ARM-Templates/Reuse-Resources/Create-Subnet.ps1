
$Arguments = @{
    ResourceGroupName = "1-5da69676-playground-sandbox"
    subnets = @(
        @{ name = "Backend"; prefix = "10.0.2.0/24" }
        @{ name = "Frontend"; prefix = "10.0.3.0/24" }
    )
    location = "East US"
    vnetName = "myVNet"
}

New-AzResourceGroupDeployment -Name Subnet @Arguments -TemplateFile Subnets-Template.json