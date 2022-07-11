$ResourceGroupName = "1-bab804f1-playground-sandbox"
$location = "East US"
$natGatewayName = "myNG"

New-AzResourceGroupDeployment -Name 'NAT-Gateway' `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile NATGateway-Template.json `
    -natGatewayName $natGatewayName `
    -location $location 