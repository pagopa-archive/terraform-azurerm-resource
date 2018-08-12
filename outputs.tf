output "id" {
  value = "${lookup(azurerm_template_deployment.resource.outputs, "id", "")}"
}

output "template_deployment_id" {
  value = "${azurerm_template_deployment.resource.id}"
}
