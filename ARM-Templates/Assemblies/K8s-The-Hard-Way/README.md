# Kubernetes The Hard Way
---

This Assembly creates infrastructure for the "Kubernetes the Hard Way" course.

It creates the following infrastructure:
1. Virtual Network
2. 2 Subnets: `controllers-subnet` and `workers-subnet`
    - For each subnet, a Network Security Group with appropriate rules
3. NAT Gateway for both subnets.
4. A Load Balancer for the controller nodes
5. Virtual machines, some workers some controllers.

## Usage
1. Generate a SSH key-pair.
2. In the `Create.ps1` script, edit:
    - Resource Group Name
    - `SSHPublicKeyPath`
3. Run `Create.ps1`


