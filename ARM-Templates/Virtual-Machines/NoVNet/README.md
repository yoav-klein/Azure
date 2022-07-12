# Virtual Machine Without a Virtual Network
---
This template is a more mature than the Basic and ConditionalVNet.

It is assumed that there is already a virtual network with a subnet.

About this template:
* Creates a Virtual Machine (Ubuntu)
* Takes a virtual network and subnet as parameters, and associates the VM to this subnet
* Conditionally creates a Public IP for the virtual machine