
$Base = "../.."

$NATGatewayName = "kthw-natGateway"
$CommonArgs = @{
    location = "eastus"
    ResourceGroupName = "1-41ff552a-playground-sandbox"
}


$VnetArgs = @{
    vnetName = "kthw-vnet"
    vnetAddressPrefix = "10.0.0.0/16"
}

$ControllersSubnet = @{
    newOrExistingVnet = "New"
    newOrExistingNSG = "Existing"
    NSGName = "kthw-controllers-nsg"
    subnetName = "kthw-controllers-subnet"
    subnetPrefix = "10.0.1.0/24"
    natGatewayName = $NATGatewayName    
}

$WorkersSubnet = @{
    newOrExistingVnet = "Existing"
    newOrExistingNSG = "Existing"
    NSGName = "kthw-workers-nsg"
    subnetName = "kthw-workers-subnet"
    subnetPrefix = "10.0.2.0/24"
    natGatewayName = $NATGatewayName
}

$LoadBalancer = @{
    lbName = "kthw-lb"
}

$Controller1 = @{
    vmName = "controller1"
    loadBalancerName = "kthw-lb"
    lbBackendPoolName = "lbBackendPool"
    virtualNetworkName = "kthw-vnet"
    subnetName = "controllersSubnet"
}

New-AzResourceGroupDeployment -Name ControllersNSG @CommonArgs -nsgName "kthw-controllers-nsg" -TemplateFile ./Controller-NSG-Template.json
New-AzResourceGroupDeployment -Name WorkersNSG     @CommonArgs -nsgName "kthw-workers-nsg"     -TemplateFile ./Worker-NSG-Template.json
New-AzResourceGroupDeployment -Name NATGateway         @CommonArgs -natGatewayName $NATGatewayName -TemplateFile $Base/Networking/NAT-Gateway/NATGateway-Template.json
New-AzResourceGroupDeployment -Name ControllersSubnet  @CommonArgs @VnetArgs @ControllersSubnet    -TemplateFile $Base/Networking/Subnet/Subnet-Template.json
New-AzResourceGroupDeployment -Name WorkersSubnet      @CommonArgs @VnetArgs @WorkersSubnet        -TemplateFile $Base/Networking/Subnet/Subnet-Template.json
# New-AzResourceGroupDeployment -Name LoadBalancer       @CommonArgs @LoadBalancer                               -TemplateFile ../Networking/Load-Balancer/LoadBalancer-Template.json
# New-AzResourceGroupDeployment  -Name ControllerVM        @CommonArgs @Controller1 -TemplateFile ../Virtual-Machines/WithLoadBalancer/VirtualMachine-Template.json