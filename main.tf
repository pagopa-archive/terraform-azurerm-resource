data "azurerm_resource_group" "resource" {
  name = "${var.resource_group}"
}

resource "azurerm_template_deployment" "resource" {
  name                = "${var.name}"
  resource_group_name = "${data.azurerm_resource_group.resource.name}"
  deployment_mode     = "${var.deployment_mode}"

  template_body = <<DEPLOY
{
    "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "apiVersion": {
            "type": "string"
        },
        "name": {
            "type": "string"
        },
        "properties": {
            "type": "string"
        },
        "sku": {
            "type": "string"
        }
    },
    "resources": [
        {
            "apiVersion": "[parameters('apiVersion')]",
            "name": "[parameters('name')]",
            "type": "${var.type}",
            "location": "[resourceGroup().location]",
            "properties": "[json(parameters('properties'))]",
            "sku": "[json(parameters('sku'))]"
        }
    ],
    "outputs": {
        "id": {
            "type": "string",
            "value": "[resourceId('${var.type}', parameters('name'))]"
        }
    }
}
DEPLOY

  parameters {
    "apiVersion" = "${var.api_version}"
    "name"       = "${var.name}"
    "properties" = "${jsonencode(var.properties)}"
    "sku"        = "${jsonencode(var.sku)}"
  }
}
