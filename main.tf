data "azurerm_resource_group" "resource" {
  name = "${var.resource_group}"
}

resource "azurerm_template_deployment" "resource" {
  name                = "${var.name}"
  resource_group_name = "${data.azurerm_resource_group.resource.name}"
  deployment_mode     = "${var.deployment_mode}"

  template_body = <<TEMPLATE
{
    "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "properties": {
            "type": "string"
        },
        "sku": {
            "type": "string"
        }
    },
    "resources": [
        {
            "apiVersion": "${var.api_version}",
            "name": "${var.name}",
            "type": "${var.type}",
            "location": "[resourceGroup().location]",
            "properties": "[json(parameters('properties'))]",
            "sku": "[json(parameters('sku'))]"
        }
    ]
}
TEMPLATE

  parameters {
    "properties" = "${jsonencode(var.properties)}"
    "sku"        = "${jsonencode(var.sku)}"
  }
}
