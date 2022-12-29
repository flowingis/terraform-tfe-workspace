locals {
  terraform_variables = { for k, v in var.terraform_variables : k =>
    {
      value       = v
      category    = "terraform"
      description = lookup(var.variables_descriptions, k, null)
    }
  }

  terraform_hcl_variables = { for k, v in var.terraform_hcl_variables : k =>
    {
      #NOTE: using @osterman trick https://github.com/hashicorp/terraform-provider-tfe/issues/188#issuecomment-700212045
      value       = replace(jsonencode(v), "/(\".*?\"):/", "$1 = ")
      category    = "terraform"
      hcl         = true
      description = lookup(var.variables_descriptions, k, null)
    }
  }

  terraform_sensitive_variables = { for k, v in var.terraform_sensitive_variables : k =>
    {
      value       = v
      category    = "terraform"
      description = lookup(var.variables_descriptions, k, null)
      sensitive   = true
    }
  }

  terraform_hcl_sensitive_variables = { for k, v in var.terraform_hcl_sensitive_variables : k =>
    {
      #NOTE: using @osterman trick https://github.com/hashicorp/terraform-provider-tfe/issues/188#issuecomment-700212045
      value       = replace(jsonencode(v), "/(\".*?\"):/", "$1 = ")
      category    = "terraform"
      description = lookup(var.variables_descriptions, k, null)
      hcl         = true
      sensitive   = true
    }
  }

  environment_variables = { for k, v in var.environment_variables : k =>
    {
      value       = v
      category    = "env"
      description = lookup(var.variables_descriptions, k, null)
    }
  }

  environment_sensitive_variables = { for k, v in var.environment_sensitive_variables : k =>
    {
      value       = v
      category    = "env"
      description = lookup(var.variables_descriptions, k, null)
      sensitive   = true
    }
  }

  all_variables = merge(
    local.terraform_variables,
    local.terraform_hcl_variables,
    local.terraform_sensitive_variables,
    local.terraform_hcl_sensitive_variables,
    local.environment_variables,
    local.environment_sensitive_variables
  )
}

resource "tfe_workspace" "this" {
  name                          = var.name
  organization                  = var.organization
  description                   = var.description
  allow_destroy_plan            = var.allow_destroy_plan
  auto_apply                    = var.auto_apply
  execution_mode                = var.execution_mode
  assessments_enabled           = var.assessments_enabled
  file_triggers_enabled         = var.file_triggers_enabled
  global_remote_state           = var.global_remote_state
  remote_state_consumer_ids     = var.remote_state_consumer_ids
  queue_all_runs                = var.queue_all_runs
  speculative_enabled           = var.speculative_enabled
  structured_run_output_enabled = var.structured_run_output_enabled
  ssh_key_id                    = var.ssh_key_id
  terraform_version             = var.terraform_version
  trigger_prefixes              = var.trigger_prefixes
  trigger_patterns              = var.trigger_patterns
  tag_names                     = var.tag_names
  working_directory             = var.working_directory
  force_delete                  = var.force_delete

  dynamic "vcs_repo" {
    for_each = length(var.vcs_repository_identifier) > 0 && length(var.oauth_token_id) > 0 ? [1] : []

    content {
      identifier         = var.vcs_repository_identifier
      branch             = var.vcs_repository_branch
      ingress_submodules = var.vcs_repository_ingress_submodules
      oauth_token_id     = var.oauth_token_id
      tags_regex         = var.vcs_repository_tags_regex
    }
  }
}

resource "tfe_variable" "this" {
  for_each = local.all_variables

  key          = each.key
  value        = each.value.value
  hcl          = try(each.value.hcl, null)
  category     = each.value.category
  description  = try(each.value.description, null)
  sensitive    = try(each.value.sensitive, false)
  workspace_id = tfe_workspace.this.id
}

resource "tfe_run_trigger" "this" {
  count = length(var.run_triggers)

  workspace_id  = tfe_workspace.this.id
  sourceable_id = var.run_triggers[count.index]
}

resource "tfe_notification_configuration" "webhook" {
  count = length(var.notification_webhook_configuration)

  name             = lookup(var.notification_webhook_configuration[count.index], "name")
  destination_type = "generic"
  enabled          = lookup(var.notification_webhook_configuration[count.index], "enabled", false)
  token            = lookup(var.notification_webhook_configuration[count.index], "token", null)
  triggers         = [for trigger in lookup(var.notification_webhook_configuration[count.index], "triggers", []) : "run:${trigger}"]
  url              = lookup(var.notification_webhook_configuration[count.index], "url")
  workspace_id     = tfe_workspace.this.id
}

resource "tfe_notification_configuration" "slack" {
  count = length(var.notification_slack_configuration)

  name             = lookup(var.notification_slack_configuration[count.index], "name")
  destination_type = "slack"
  enabled          = lookup(var.notification_slack_configuration[count.index], "enabled", false)
  triggers         = [for trigger in lookup(var.notification_slack_configuration[count.index], "triggers", []) : "run:${trigger}"]
  url              = lookup(var.notification_slack_configuration[count.index], "url")
  workspace_id     = tfe_workspace.this.id
}

resource "tfe_notification_configuration" "microsoft_teams" {
  count = length(var.notification_microsoft_teams_configuration)

  name             = lookup(var.notification_microsoft_teams_configuration[count.index], "name")
  destination_type = "microsoft-teams"
  enabled          = lookup(var.notification_microsoft_teams_configuration[count.index], "enabled", false)
  triggers         = [for trigger in lookup(var.notification_microsoft_teams_configuration[count.index], "triggers", []) : "run:${trigger}"]
  url              = lookup(var.notification_microsoft_teams_configuration[count.index], "url")
  workspace_id     = tfe_workspace.this.id
}

resource "tfe_workspace_variable_set" "this" {
  for_each = toset(var.variable_set_ids)

  variable_set_id = each.key
  workspace_id    = tfe_workspace.this.id
}
