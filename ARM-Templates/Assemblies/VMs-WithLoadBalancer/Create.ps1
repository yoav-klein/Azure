
$Base = "../.."
$SubnetTemplate = "$Base/Networking/Subnet/Subnet-Template.json"
$VMTemplateFile = "$Base/Virtual-Machines/WithLoadBalancer/VirtualMachine-Template.json"
$LoadBalancerTemplateFile = "$Base/Networking/Load-Balancer/LoadBalancer-Template.json"
$ResourceGroupName = "1-41ff552a-playground-sandbox"

$CommonArguments = @{
    ResourceGroupName = $ResourceGroupName
    location = "East US"
    virtualNetworkName = "myVNet"
    subnetName = "mySubnet"
}

$NSG = @{
    nsgName = "myNSG"
    location = $CommonArguments.location
    ResourceGroupName = $CommonArguments.ResourceGroupName
}

$Subnet = @{
    vnetName =  $CommonArguments.virtualNetworkName
    newOrExistingVnet = "New"
    location = "East US"
    vnetAddressPrefix = "10.0.0.0/16"
    newOrExistingNSG = "Existing"
    NSGName = "myNSG"
    subnetName = $CommonArguments.subnetName
    subnetPrefix = "10.0.1.0/24"
}


$LoadBalancer = @{
    location = "eastus"
    lbName = "myLB"
    lbBackendPoolName = "myLBBackend"
}

$VMCommon = @{
    adminUserName = "yoav"
    authenticationType = "password"
    loadBalancerName = "myLB"
    lbBackendPoolName = "myLBBackend"
}

$First = @{
    vmName = "vm1"
    publicIp = $true
}

$Second = @{
    vmName = "vm2"
    publicIp = $true
}

$Third = @{
    vmName = "vm3"
    publicIp = $true
}


New-AzResourceGroupDeployment -Name NSG @NSG -TemplateFile ./NSG-Template.json
New-AzResourceGroupDeployment -Name VirtualNetwork -ResourceGroupName $ResourceGroupName @Subnet -TemplateFile $SubnetTemplate
New-AzResourceGroupDeployment -Name LoadBalancer   -ResourceGroupName $ResourceGroupName @LoadBalancer -TemplateFile $LoadBalancerTemplateFile
New-AzResourceGroupDeployment -Name VirtualMachine @CommonArguments @VMCommon @First -TemplateFile $VMTemplateFile
New-AzResourceGroupDeployment -Name VirtualMachine @CommonArguments @VMCommon @Second -TemplateFile $VMTemplateFile
New-AzResourceGroupDeployment -Name VirtualMachine @CommonArguments @VMCommon @Third -TemplateFile $VMTemplateFile