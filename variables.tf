variable "location" {
    default="West Europe"
    description = "Region where to deploy resources"
  
}
variable "subscription_id" {
    type = string
    sensitive = true
    description = "Subscription id of the user"
}