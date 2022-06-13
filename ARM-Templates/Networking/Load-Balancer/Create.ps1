
$Arguments = @{
    ResourceGroupName = "1-ab7d8dd8-playground-sandbox"
    location = "eastus"
    lbName = "myLB"
    lbIPName = "lbIP"
}

New-AzResourceGroupDeployment -Name "LoadBalancer"  @Arguments -TemplateFile LoadBalancer-Template.json