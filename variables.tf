variable "api_version" {
  description = "Version of the REST API to use for creating the resource."
}

variable "deployment_mode" {
  default     = "Incremental"
  description = "Specifies the mode that is used to deploy resources. This value could be either Incremental or Complete."
}

variable "name" {
  description = "Name of the resource. The name must follow URI component restrictions defined in RFC3986."
}

variable "properties" {
  default     = {}
  description = "Resource-specific configuration settings. The values for the properties are the same as the values you provide in the request body for the REST API operation (PUT method) to create the resource."
}

variable "resource_group" {
  description = " The name of the resource group in which to create the template deployment."
}

variable "sku" {
  default     = {}
  description = "Some resources allow values that define the SKU to deploy. For example, you can specify the type of redundancy for a storage account."
}

variable "type" {
  description = "Type of the resource. This value is a combination of the namespace of the resource provider and the resource type (such as Microsoft.Storage/storageAccounts)."
}
