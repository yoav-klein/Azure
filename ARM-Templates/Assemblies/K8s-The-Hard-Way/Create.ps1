
$Base = "../.."

$NATGatewayName = "kthw-natGateway"
$CommonArgs = @{
    location = "eastus"
    ResourceGroupName = "1-62f47641-playground-sandbox"
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
    lbBackendPoolName = "kthw-lb-backendPool"
}

$Controller1 = @{
    vmName = "controller1"
    loadBalancerName = "kthw-lb"
    lbBackendPoolName = "kthw-lb-backendPool"
    virtualNetworkName = "kthw-vnet"
    subnetName = "kthw-controllers-subnet"
    adminUserName = "yoav"
    publicIp = $true
}

$Worker1 = @{
    vmName = "worker1"
    virtualNetworkName = "kthw-vnet"
    subnetName = "kthw-workers-subnet"
    adminUserName = "yoav"
    publicIp = $true
}

# New-AzResourceGroupDeployment -Name ControllersNSG     @CommonArgs -nsgName "kthw-controllers-nsg" -TemplateFile ./Controller-NSG-Template.json
# New-AzResourceGroupDeployment -Name WorkersNSG         @CommonArgs -nsgName "kthw-workers-nsg"     -TemplateFile ./Worker-NSG-Template.json
# New-AzResourceGroupDeployment -Name NATGateway         @CommonArgs -natGatewayName $NATGatewayName -TemplateFile $Base/Networking/NAT-Gateway/NATGateway-Template.json
# New-AzResourceGroupDeployment -Name ControllersSubnet  @CommonArgs @VnetArgs @ControllersSubnet    -TemplateFile $Base/Networking/Subnet/Subnet-Template.json
# New-AzResourceGroupDeployment -Name WorkersSubnet      @CommonArgs @VnetArgs @WorkersSubnet        -TemplateFile $Base/Networking/Subnet/Subnet-Template.json
# New-AzResourceGroupDeployment -Name LoadBalancer       @CommonArgs @LoadBalancer                   -TemplateFile ./LoadBalancer-Template.json
#New-AzResourceGroupDeployment -Name ControllerVM1      @CommonArgs @Controller1                    -TemplateFile $Base/Virtual-Machines/WithLoadBalancer/VirtualMachine-Template.json
New-AzResourceGroupDeployment -Name WorkerVM1          @CommonArgs @Worker1                        -TemplateFile $Base/Virtual-Machines/NoVNet/VirtualMachine-Template.json