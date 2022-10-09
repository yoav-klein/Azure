
$ErrorActionPreference = "Stop"

$Base = "../.."
$AzUserName = "cloud_user_p_a9500d94@azurelabs.linuxacademy.com"
$AzPassword = "4arKQ0IEFanRSa8q@0sB"
$SSHPublicKeyPath = "./azure.pub"

$CommonArgs = @{
    location = "Germany West Central"
    ResourceGroupName = ""
}

$VNet = @{
    vnetName = "kube-vnet"
    newOrExistingVnet = "New"
    vnetAddressPrefix = "10.0.0.0/16"
    newOrExistingNSG = "New"
    NSGName = "kube-nsg"
    subnetName = "kube-subnet"
    subnetPrefix = "10.0.1.0/24"
}

$VMCommon = @{
    adminUserName = "yoav"
    authenticationType = "sshPublicKey"
    adminPasswordOrKey = cat $SSHPublicKeyPath | ConvertTo-SecureString -AsPlainText -Force
}

$Controller = @{
    vmName = "controller"
    virtualNetworkName = $VNet.vnetName
    subnetName = $VNet.subnetName
    publicIp = $true
}


$Worker1 = @{
    vmName = "worker1"
    virtualNetworkName = $VNet.vnetName
    subnetName = $VNet.subnetName
    publicIp = $true
}


$Worker2 = @{
    vmName = "worker2"
    virtualNetworkName = $VNet.vnetName
    subnetName = $VNet.subnetName
    publicIp = $true
}

function Create-Account {
    $SecurePassword = ConvertTo-SecureString $AzPassword -AsPlainText -Force
    $Cred = New-Object System.Management.Automation.PSCredential($AzUserName, $SecurePassword)
    Connect-AzAccount -Credential $Cred
    $RGN = $(Get-AzResourceGroup).ResourceGroupName
    $script:CommonArgs.ResourceGroupName = $RGN
}

function Create-Resources {
    New-AzResourceGroupDeployment -Name VirtualNetwork @CommonArgs @Vnet                 -TemplateFile $Base/Networking/Subnet/Subnet-Template.json
    New-AzResourceGroupDeployment -Name ControllerVM   @CommonArgs @VMCommon @Controller -TemplateFile $Base/Virtual-Machines/NoVNet/VirtualMachine-Template.json
    New-AzResourceGroupDeployment -Name WorkerVM1      @CommonArgs @VMCommon @Worker1    -TemplateFile $Base/Virtual-Machines/NoVNet/VirtualMachine-Template.json
    New-AzResourceGroupDeployment -Name WorkerVM2      @CommonArgs @VMCommon @Worker2    -TemplateFile $Base/Virtual-Machines/NoVNet/VirtualMachine-Template.json
}

function Write-ResourcesData {
    "resourceGroupName: $($CommonArgs.ResourceGroupName)" > resources.txt
    "controller: $($(Get-AzResourceGroupDeployment -ResourceGroupName $CommonArgs.ResourceGroupName -Name ControllerVM).Outputs.hostname.value)" >> resources.txt
    "worker1: $($(Get-AzResourceGroupDeployment -ResourceGroupName $CommonArgs.ResourceGroupName -Name WorkerVM1).Outputs.hostname.value)" >> resources.txt
    "worker2: $($(Get-AzResourceGroupDeployment -ResourceGroupName $CommonArgs.ResourceGroupName -Name WorkerVM2).Outputs.hostname.value)" >> resources.txt
}

function Copy-Key {
    $HostName = $(Get-AzResourceGroupDeployment -ResourceGroupName $CommonArgs.ResourceGroupName -Name ControllerVM).Outputs.hostname.value
    scp -o StrictHostKeyChecking=no -i azure azure "$($VMCommon.adminUserName)@$($HostName):~/.ssh/id_rsa"
    ssh -o StrictHostKeyChecking=no -i azure "$($VMCommon.adminUserName)@$($HostName)" chmod 0700 ~/.ssh/id_rsa
}

Create-Account
Create-Resources
Write-ResourcesData
Copy-Key