# VNet and Subnets - Flexible
---

In this example, we split the virtual network creation into 2 templates: one for the virtual network, and
one for the subnets.

This enables you to create subnets for an existing virtual network, and also
create a variable number of subnets.

This example utilizes the `copy` feature in ARM templates.
