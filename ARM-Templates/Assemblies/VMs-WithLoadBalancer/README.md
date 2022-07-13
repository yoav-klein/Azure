# VMs with Load Balancer
---

This assembly creates a set of virtual machines and a load balancer which load-balances
traffic between them.

We create the following resources:
1. A Network Security Group - which allows incoming SSH and HTTP traffic
2. A Virtual Network with one subnet - associated with the NSG above.
3. A Load Balancer (and a public IP for it)
4. 3 Virtual Machines associated with the Load Balancer


## Usage
---
1. Fill in the resource group name in `Create.ps1`.
2. Generate a SSH key-pair.
3. Run `Create.ps1` , and give the public key in the creation of the virtual machines.
4. Edit the `Deploy.ps1`, fill in the path of the private key, and run it.

## Test
---
Take the IP of the Load Balancer, and run:
```
$ curl <load-balancer-IP>
```
several times. You should get a different host name each time.