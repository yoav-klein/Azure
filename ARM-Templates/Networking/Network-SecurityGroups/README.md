# Network Security Groups
---

This is a reference ARM template to create a `networkSecurityGroup` resource.

A NSG is created as a resource of its own, but usually you'll include it in a template that creates a Virtual Network,
since you need to associate the NSG to a subnet, and this is done by specifying the ID of the NSG 
in the `subnet` section inside the virtual network spec in the template, or in a spec of a `subnet` 
when it is defined as a resource of its own.


Reference: 
https://docs.microsoft.com/en-us/azure/templates/microsoft.network/networksecuritygroups?tabs=bicep
