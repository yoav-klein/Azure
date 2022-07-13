$PathToPrivateKey = "../../../azure"

function Setup-Machine($MachineName) {
    $MachinePubIPName = "$($MachineName)-pub-ip"
    $IPAddress = $(Get-AzPublicIpAddress -Name $MachinePubIPName).IpAddress

    scp -i $PathToPrivateKey -o "StrictHostKeyChecking=no" ./setup.sh yoav@$($IPAddress):~
    scp -i $PathToPrivateKey -o "StrictHostKeyChecking=no" ./webapp.py yoav@$($IPAddress):~

    ssh -i $PathToPrivateKey -o "StrictHostKeyChecking=no" "yoav@$($IPAddress)" "chmod +x ./setup.sh && ./setup.sh"
    ssh -i $PathToPrivateKey -o "StrictHostKeyChecking=no" "yoav@$($IPAddress)" "sudo python3 webapp.py &"
    
}


Setup-Machine "vm1"
Setup-Machine "vm2"
Setup-Machine "vm3"
