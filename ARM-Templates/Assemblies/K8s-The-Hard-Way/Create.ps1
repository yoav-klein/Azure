
$Base = "../.."
$SSHPublicKeyPath = "./azure.pub"

$AzUserName = "cloud_user_p_5416c31b@azurelabs.linuxacademy.com"
$AzPassword = "C9Mbg#wUla8Fb8jYCQyD"

$NATGatewayName = "kthw-natGateway"
$CommonArgs = @{
    location = "Germany West Central"
    ResourceGroupName = ""
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

$VMCommon = @{
    adminUserName = "yoav"
    authenticationType = "sshPublicKey"
    adminPasswordOrKey = cat $SSHPublicKeyPath | ConvertTo-SecureString -AsPlainText -Force
}

$Controller1 = @{
    vmName = "controller1"
    loadBalancerName = $LoadBalancer.lbName
    lbBackendPoolName = $LoadBalancer.lbBackendPoolName
    virtualNetworkName = $VnetArgs.vnetName
    subnetName = $ControllersSubnet.subnetName
    publicIp = $true
}

$Controller2 = @{
    vmName = "controller2"
    loadBalancerName = $LoadBalancer.lbName
    lbBackendPoolName = $LoadBalancer.lbBackendPoolName
    virtualNetworkName = $VnetArgs.vnetName
    subnetName = $ControllersSubnet.subnetName
    publicIp = $true
}

$Worker1 = @{
    vmName = "worker1"
    virtualNetworkName = $VnetArgs.vnetName
    subnetName = $WorkersSubnet.subnetName
    publicIp = $true
}

$Worker2 = @{
    vmName = "worker2"
    virtualNetworkName = $VnetArgs.vnetName
    subnetName = $WorkersSubnet.subnetName
    publicIp = $true
}



function Create-Resources {
    $ErrorActionPreference = "Stop"
    New-AzResourceGroupDeployment -Name ControllersNSG     @CommonArgs -nsgName "kthw-controllers-nsg" -TemplateFile ./Controller-NSG-Template.json
    New-AzResourceGroupDeployment -Name WorkersNSG         @CommonArgs -nsgName "kthw-workers-nsg"     -TemplateFile ./Worker-NSG-Template.json
    New-AzResourceGroupDeployment -Name NATGateway         @CommonArgs -natGatewayName $NATGatewayName -TemplateFile $Base/Networking/NAT-Gateway/NATGateway-Template.json
    New-AzResourceGroupDeployment -Name ControllersSubnet  @CommonArgs @VnetArgs @ControllersSubnet    -TemplateFile $Base/Networking/Subnet/Subnet-Template.json
    New-AzResourceGroupDeployment -Name WorkersSubnet      @CommonArgs @VnetArgs @WorkersSubnet        -TemplateFile $Base/Networking/Subnet/Subnet-Template.json
    New-AzResourceGroupDeployment -Name LoadBalancer       @CommonArgs @LoadBalancer                   -TemplateFile ./LoadBalancer-Template.json
    New-AzResourceGroupDeployment -Name ControllerVM1      @CommonArgs @VMCommon @Controller1          -TemplateFile $Base/Virtual-Machines/WithLoadBalancer/VirtualMachine-Template.json
    New-AzResourceGroupDeployment -Name WorkerVM1          @CommonArgs @VMCommon @Worker1              -TemplateFile $Base/Virtual-Machines/NoVNet/VirtualMachine-Template.json
    New-AzResourceGroupDeployment -Name ControllerVM2      @CommonArgs @VMCommon @Controller2          -TemplateFile $Base/Virtual-Machines/WithLoadBalancer/VirtualMachine-Template.json
    New-AzResourceGroupDeployment -Name WorkerVM2          @CommonArgs @VMCommon @Worker2              -TemplateFile $Base/Virtual-Machines/NoVNet/VirtualMachine-Template.json
}

function Create-Account {
    $SecurePassword = ConvertTo-SecureString $AzPassword -AsPlainText -Force
    $Cred = New-Object System.Management.Automation.PSCredential ($AzUserName, $SecurePassword)
    Connect-AzAccount -Credential $Cred
    $RGN = $(Get-AzResourceGroup).ResourceGroupName
    $script:CommonArgs.ResourceGroupName = $RGN
    
}

function Write-ResourcesData {
    "resourceGroupName: $($CommonArgs.ResourceGroupName)" > resources.txt
    "controller1: $($(Get-AzResourceGroupDeployment -ResourceGroupName $CommonArgs.ResourceGroupName -Name ControllerVM1).Outputs.hostname.value)" >> resources.txt
    "controller2: $($(Get-AzResourceGroupDeployment -ResourceGroupName $CommonArgs.ResourceGroupName -Name ControllerVM2).Outputs.hostname.value)" >> resources.txt
    "worker1: $($(Get-AzResourceGroupDeployment -ResourceGroupName $CommonArgs.ResourceGroupName -Name WorkerVM1).Outputs.hostname.value)" >> resources.txt
    "worker2: $($(Get-AzResourceGroupDeployment -ResourceGroupName $CommonArgs.ResourceGroupName -Name WorkerVM2).Outputs.hostname.value)" >> resources.txt
    "loadBalancerDomainName: $($(Get-AzResourceGroupDeployment -ResourceGroupName $CommonArgs.ResourceGroupName -Name LoadBalancer).Outputs.domainName.value)" >> resources.txt
    
}

Create-Account
Create-Resources
Write-ResourcesData