provider "azurerm" {
  version = "~> 1.13"
}

resource "random_uuid" "random_deployment_name" {}

resource "azurerm_template_deployment" "resource" {
  name                = "${var.random_deployment_name ? random_uuid.random_deployment_name.result : var.name}"
  resource_group_name = "${var.resource_group_name}"
  deployment_mode     = "${var.deployment_mode}"

  template_body = <<DEPLOY
{
    "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "apiVersion": {
            "type": "string"
        },
        "kind": {
            "type": "string"
        },
        "location": {
            "type": "string"
        },
        "name": {
            "type": "string"
        },
        "plan": {
            "type": "string"
        },
        "properties": {
            "type": "string"
        },
        "sku": {
            "type": "string"
        },
        "tags": {
            "type": "string"
        }
    },
    "resources": [
        {
            "apiVersion": "[parameters('apiVersion')]",
            "name": "[parameters('name')]",
            "type": "${var.type}",
            ${var.location != "" ? "\"location\":\"[parameters('location')]\"," : ""}
            "properties": "[json(parameters('properties'))]",
            ${var.kind != "" ? "\"kind\":\"[parameters('kind')]\"," : ""}
            ${length(var.plan) > 0 ? "\"plan\":\"[json(parameters('plan'))]\"," : ""}
            ${length(var.sku) > 0 ? "\"sku\":\"[json(parameters('sku'))]\"," : ""}
            "tags": "[json(parameters('tags'))]"
            "comments": "This deployment must follows : ${var.depends_on[0]} ",
        }
    ],
 "outputs": {
        ${var.enable_output? "\"id\": { \"type\": \"string\",\"value\": \"[resourceId('${var.type}', parameters('name'))]\"        }": ""}
    }
}
DEPLOY

  parameters = {
    "apiVersion" = "${var.api_version}"
    "kind"       = "${var.kind}"
    "location"   = "${var.location}"
    "name"       = "${var.name}"
    "plan"       = "${jsonencode(var.plan)}"

    # Jsonencode bug when working with numeric values
    # Details here https://github.com/hashicorp/terraform/issues/17033
    # Fixed in terraform 0.12
    # "properties" = "${jsonencode(var.properties)}"
    "properties" = "${replace(replace("${jsonencode(var.properties)}","/\"(true|false|[[:digit:]]+|-[[:digit:]]+)\"/", "$1"), "string:", "")}"

    "sku"  = "${jsonencode(var.sku)}"
    "tags" = "${jsonencode(var.tags)}"
  }
}
