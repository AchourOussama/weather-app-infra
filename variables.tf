variable "location" {
    default="West Europe"
    description = "Region where to deploy resources"
}

variable "AZURE_SUBSCRIPTION_ID" {
    type = string
    sensitive = true
    description = "Subscription id of the user"
}
variable "AZURE_TENANT_ID" {
    type = string
    sensitive = true
    description = "Tenant id of the user"
}
variable "AZURE_CLIENT_SECRET" {
    type = string
    sensitive = true
    description = "Password of the service principal"
}
variable "AZURE_CLIENT_ID" {
    type = string
    sensitive = true
    description = "Service principal id "
}