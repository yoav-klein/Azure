# Virtual Machine with Load Balancer
---

This template creates a virtual machine and connects it to a Load Balancer.

It is assumed that there is already a virtual network with a subnet, and a Load Balancer
with a Backend Address Pool.

You need to specify the Load Balancer name AND the Backend Address Pool name, 
and the virtual machine's Network Interface will associate itself with that Backend Address Pool.

Additionally, use the `publicIP` boolean parameter to determine whether or not to create a public IP for the VM.


