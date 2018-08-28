output "id" {
  description = "The resource ID."
  value       = "${lookup(azurerm_template_deployment.resource.outputs, "id", "")}"
}

output "template_deployment_id" {
  description = "The template deployment ID."
  value       = "${azurerm_template_deployment.resource.id}"
}
