
$Arguments = @{
    ResourceGroupName = "1-5da69676-playground-sandbox"
    location = "East US"
    vmName = "myLinux"
    adminUserName = "yoav"
    authenticationType = "password"
    #adminPasswordOrKey = "Yoav-Klein12"
    ubuntuOSVersion = "18.04-LTS"
    vmSize = "Standard_B2s"

}

New-AzResourceGroupDeployment -Name VirtualMachine @Arguments -TemplateFile VirtualMachine-Template.json