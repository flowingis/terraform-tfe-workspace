variable "tfc_token" {
  description = "Token for Terraform Cloud Authentication"
  type        = string
  sensitive   = true
}

variable "secret_token" {
  description = "A secret token used in some resource configuration"
  type        = string
  sensitive   = true
}

variable "access_key_id" {
  description = "Access Key ID to access AWS Account"
  type        = string
  sensitive   = true
}

variable "secret_access_key" {
  description = "Secret Access Key to access AWS Account"
  type        = string
  sensitive   = true
}

variable "slack_notification_url" {
  description = "URL of Webhook to a Slack Channel used for Terraform Cloud Runs notifications"
  type        = string
  sensitive   = true
}

variable "webhooh_notification_token" {
  description = "A write-only secure token for the notification configuration of 'Webhook' type"
  type        = string
  sensitive   = true
}

variable "webhook_notification_url" {
  description = "The HTTP or HTTPS URL of the notification configuration where notification requests will be made"
  type        = string
  sensitive   = true
}
