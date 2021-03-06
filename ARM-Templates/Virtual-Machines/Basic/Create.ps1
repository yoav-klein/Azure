
$Arguments = @{
    ResourceGroupName = "1-62f47641-playground-sandbox"
    location = "East US"
    vmName = "myLinux"
    adminUserName = "yoav"
    authenticationType = "password"
    #adminPasswordOrKey = "Yoav-Klein12"
    ubuntuOSVersion = "18.04-LTS"
    vmSize = "Standard_B2s"

}

New-AzResourceGroupDeployment -Name VirtualMachine @Arguments -TemplateFile VirtualMachine-Template.json