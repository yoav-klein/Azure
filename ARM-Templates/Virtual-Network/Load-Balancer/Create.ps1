
$Arguments = @{
    ResourceGroupName = "1-d27fc885-playground-sandbox"
    location = "eastus"
    lbName = "myLB"
    lbIPName = "lbIP"
}

New-AzResourceGroupDeployment -Name "LoadBalancer"  @Arguments -TemplateFile LoadBalancer-Template.json