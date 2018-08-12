# Create any Azure resource

Create or update any Azure resource.

This module provisions the following resources:

- [`azurerm_template_deployment`](https://www.terraform.io/docs/providers/azurerm/r/template_deployment.html)


**Note⚠️** Due to the way the underlying Azure API is designed, Terraform can only manage the deployment of the ARM Template - and not any resources which are created by it. This means that when deleting the [`azurerm_template_deployment`](https://www.terraform.io/docs/providers/azurerm/r/template_deployment.html) resource, Terraform will only remove the reference to the deployment, whilst leaving any resources created by that ARM Template Deployment. One workaround for this is to use a unique Resource Group for each ARM Template Deployment, which means deleting the Resource Group would contain any resources created within it - however this isn't ideal.

## Usage

Example 1 (Integration Account):

```hcl
module "integration_account" {
  source         = "innovationnorway/resource/azurerm"
  api_version    = "2016-06-01"
  type           = "Microsoft.Logic/IntegrationAccounts"
  name           = "my-integration-account"
  resource_group = "my-integration-account-rg"

  sku {
    name = "Standard"
  }
}
```

Example 2 (App Service Plan):

```hcl
module "premium_container_plan" {
  source         = "innovationnorway/resource/azurerm"
  api_version    = "2018-02-01"
  type           = "Microsoft.Web/serverfarms"
  name           = "my-premium-container-plan"
  resource_group = "my-container-rg"

  properties = {
    kind = "xenon"
  }

  sku {
    name   = "PC3"
    tier   = "PremiumContainer"
    size   = "PC3"
    family = "PC"
  }
}
```

**Tip💡** Use native Terraform resources where possible rather than ARM Templates.

## Inputs

### name

(Required) Name of the resource.

### resource_group

(Required) The name of the resource group in which to create the template deployment.

### api_version

(Required) Version of the REST API to use for creating the resource.

### deployment_mode

Specifies the mode that is used to deploy resources. This value could be either `Incremental` or `Complete`. Note that you will almost always want this to be set to `Incremental` otherwise the deployment will destroy all infrastructure not specified within the template, and Terraform will not be aware of this. Default is `Incremental`.

### type

(Required) Type of the resource. This value is a combination of the namespace of the resource provider and the resource type (such as `Microsoft.Storage/storageAccounts`).

### properties

(Optional) Resource-specific configuration settings. The values for the properties are the same as the values you provide in the request body for the REST API operation (PUT method) to create the resource.

### sku

(Optional) Some resources allow values that define the SKU to deploy. For example, you can specify the type of redundancy for a storage account.


## Outputs

### id

The resource ID.

### name

The resource name.

### template_deployment_id

The template deployment ID.

