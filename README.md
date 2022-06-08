# ARM Templates
---


## Introduction

ARM (Azure Resource Manager) templates are special IaC for Azure. They allow you to describe your infrastructure as code, and then easily deploy a complex set of resources and configurations in a single command.

A template basically consists of a list of resources, and is deployed to a Resource Group.
It is called a template since you can define parameters in the template, and set them 
when you deploy the template. For example, you may create a `location` parameter, so 
each time you deploy a template you can set the location on the fly.

[Official Docs](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/overview)


## Setup
There are several ways to deploy a template.

### Powershell
We can use the Azure Powershell module to do any operation in our Azure subscription, including deploying ARM templates.

<b>Install the Powershell module</b>
```
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
```

<b>Connect to Azure</b>
Next, you'll need to connect to your Azure account and supply credentials.

```
Connect-AzAccount
```

<b>Deploy a template</b>

In order to deploy a template, we use the `New-AzResourceGroupDeployment` cmdlet shipped with the Azure module.

example:
```
> New-AzResourceGroupDeployment -ResourceGroupName "myRG" -TemplateFile <pathToFile> [templateParameters]
```