# Flexible Virtual Machine
---

In the "Simple" Virtual Machine ARM template, we create along with our virtual machine also
a virtual network, subnet, network secuirty group (for the VM - not the subnet).

This is rather monolithic: What if I have an existing subnet to which I want to attach my virtual machine?

This template creates a Virtual Machine, and allows the user the option to connect it to a ready-made subnet.

## Conditions
---
You can add `condition` to resource definitions in ARM template, in which you specify
a condition that only if valid - the resource will be created.

So in this template, we add another parameter: `newOrExitingVNet` that the user sets to determine
if he wants to create a new virtual network or use an existing one.

The resources: virtual network, subnet, and network security group are conditionally created depending on the
value of this parameter.

Reference: [Use conditions in ARM template](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-tutorial-use-conditions)

## Pitfall: Conditional properties
Conditional resources is easy - you just specify a `condition` field in the resource definition. But in our case, we also need a conditional property.

When creating a virtual machine, we also create a `networkInterface`. In case we create a new VNet, we create a Network Security Group and associate the network interface with this NSG. But in case we use an existing, we don't want to create a new NSG, but rather rely on the NSG of the subnet (supposing that it exists..)

In this case, we use the trick introduced in [this article](https://mattfrear.com/2020/06/17/conditionally-specify-a-property-in-an-arm-template/)

See what we've done inside, too long to explain here.

## Usage
---
The use-case we're demonstrating here is where you already have a subnet, and you want to create several VMs and connect them to the subnet. This is done in the scripting level - define a set of common arguments: location, virtual network, subnet, etc. and a set of specific arguments for each VM, and then apply the template once for each machine.