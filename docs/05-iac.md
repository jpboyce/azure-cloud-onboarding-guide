# 05 - Infrastructure as Code

## Introduction

Infrastructure-as-Code (IaC) is an approach to managing infrastructure using principles taken from the world of software development.  Some of the key points of this are:

- Avoid manual configuration: By using automation, teams avoid doing manual changes via "ClickOps", which can lead to configuration drift and inconsistency in environments
- Rapid delivery: Generally when using IaC, it becomes easier to add new environments or roll out new components to an environment.  Environments can also be provisioned and destroyed quickly on demand
- Declarative definitions: The components and configuration of the environment are described in a declarative definition file.  It defines the desired end state, not the steps to achieve it

## ARM Templates

Azure Resource Manager (ARM) Templates were the original IaC option for Azure.  These templates use a JSON format and are comparable to AWS's Cloudformation templates.  ARM templates can have the following sections:

- Parameters: Values that are provided during deployment to customise the deployment in some way
- Variables: Values that are reused in templates.  Often they are constructed using Parameters
- Resources: The resources that will be deployed
- Outputs: Values that are returned when the deployment is completed

An issue with ARM templates is due to their use of JSON, they can be verbose and hard to read/maintain, especially for templates that define larger systems.

## Bicep

Bicep is a domain-specific language that builds on top of ARM templates.  It follows the same concepts as ARM templates but uses a more simple syntax.  A Bicep file is typically 1/4 the size of an ARM template.  It looks similar to Terraform.  A comparison of ARM vs Bicep code is below.

=== "ARM Template"

    ``` json linenums="1"
    {
      "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {
        "location": {
          "type": "string",
          "defaultValue": "[resourceGroup().location]"
        }
      },
      "resources": {
        "mystore": {
          "type": "Microsoft.Storage/storageAccounts",
          "apiVersion": "2023-05-01",
          "name": "mystorageaccount",
          "location": "[parameters('location')]",
          "sku": {
            "name": "Standard_LRS"
          },
          "kind": "StorageV2"
        }
      }
    }
    ```

=== "Bicep"

    ``` bicep linenums="1"
    param location string = resourceGroup().location

    resource mystore 'Microsoft.Storage/storageAccounts@2023-05-01' = {
      name: 'mystorageaccount'
      location: location
      sku: {
        name: 'Standard_LRS'
      }
      kind: 'StorageV2'
    }
    ```

A benefit of Bicep is it has immediate support of all API versions for Azure services.

### Testing and Deploying Bicep Code

Bicep has a built-in linter that can check the syntax of the code.  The Bicep extension for Visual Studio Code can also do this. There is a tool called PSrule maintained by a Microsoft employee that can assess both ARM templates and Bicep code against rules.  The included rules check for alignment with the Well Architected Framework. This ensures the resources defined in the code will be responsibly designed.

For deployment, Bicep has a "what-if" command that will model what changes are likely to happen when the code is executed.  The output is will include information about what resources will be created, changed, destroyed or left unchanged.  It is not infalliable, as in some cases a what-if may look ok but the deployment will fail for some reason.

The actual deployment is performed using command-line tools like `az deployment`.  While this can be executed locally, the recommended and more mature approach is to do deployments using a CI/CD pipeline in a platform like Azure DevOps or Github.  This allows more control and consistency over the process.