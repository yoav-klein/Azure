$resourceGroupName = "1-83d9f63a-playground-sandbox"
$location = "East US"
$nsgName = "myNSG"

New-AzResourceGroupDeployment -Name 'Netwrok-SecurityGroup' `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile NSG-Template.json `
    -nsgName $nsgName `
    -location $location 