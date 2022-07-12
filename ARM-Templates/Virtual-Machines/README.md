# Virtual Machines
---

This folder contains templates for creating virtual machines.

The `Basic` is, well, basic. It creates a virtual machine along with a virtual network, subnet, etc.

The `ConditionalVNet` demonstrates a use of conditions to conditionally create the virtual network and subnet.

The more useful ones are the `NoVNet`  and `WithLoadBalancer`. Those doesn't create a virtual network, since it's better that you'll create the virtual network and subnet before you create the virtual machine. It's recommended you'll use those templates.