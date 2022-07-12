
$Arguments = @{
    ResourceGroupName = "1-0c5ee206-playground-sandbox"
    location = "eastus"
    lbName = "myLB"
    lbBackendName = "myBackendAddressPool"
}

New-AzResourceGroupDeployment -Name "LoadBalancer"  @Arguments -TemplateFile LoadBalancer-Template.json