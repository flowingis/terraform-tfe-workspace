terraform {
  required_version = "~> 1.3.0"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.40.0"
    }
  }
}

provider "tfe" {
  token = var.tfc_token
}

# Use existing organization
data "tfe_organization" "myorg" {
  name = "myorg"
}

# Use a dedicated project for this workspace
resource "tfe_project" "myproject" {
  organization = data.tfe_organization.myorg.name
  name         = "myproject"
}

module "advanced_workspace" {
  source = "../../"

  name              = "advanced-workspace"
  organization      = data.tfe_organization.myorg.name
  description       = "An advanced Terraform Cloud/Enterprise workspace"
  terraform_version = "1.3.7"

  project_id = tfe_project.myproject.id

  terraform_variables = {
    string_variable = "stringvalue"
    number_variable = 1
    bool_variable   = true
  }

  terraform_sensitive_variables = {
    secret_token = var.secret_token
  }

  terraform_hcl_variables = {
    list_of_values = ["a", "b", "c"]
    map_of_values = {
      key1 = "value1"
      key2 = "value2"
      key3 = 12345
    }
  }

  environment_sensitive_variables = {
    AWS_ACCESS_KEY_ID     = var.access_key_id     #NOTE: sensitive value
    AWS_SECRET_ACCESS_KEY = var.secret_access_key #NOTE: sensitive value
  }

  variables_descriptions = {
    string_variable       = "A variable containing a value in string format"
    number_variable       = "A variable containing a value in number format"
    bool_variable         = "A variable containing a value in boolean format"
    list_of_values        = "A variable in HCL format containing a value in list of strings format"
    map_of_values         = "A variable in HCL format containing a value in map of items"
    AWS_ACCESS_KEY_ID     = "Access Key ID to access AWS Account"
    AWS_SECRET_ACCESS_KEY = "Secret Access Key to access AWS Account"
  }

  notification_slack_configuration = [
    {
      name     = "my-slack-notification"
      enabled  = true
      url      = var.slack_notification_url
      triggers = ["needs_attention", "completed", "errored"]
    }
  ]

  notification_webhook_configuration = [
    {
      name     = "my-webhook-notification"
      enabled  = true
      token    = var.webhooh_notification_token
      url      = var.webhook_notification_url
      triggers = ["needs_attention", "completed", "errored"]
    }
  ]
}
