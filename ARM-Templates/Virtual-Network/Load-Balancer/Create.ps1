
$Arguments = @{
    ResourceGroupName = "1-2c3e846e-playground-sandbox"
    location = "eastus"
    lbName = "myLB"
    lbIPName = "lbIP"
}

New-AzResourceGroupDeployment -Name "LoadBalancer"  @Arguments -TemplateFile LoadBalancer-Template.json