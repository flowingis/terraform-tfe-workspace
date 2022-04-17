data "tfe_oauth_client" "this" {
  count           = length(var.oauth_client_id) > 0 ? 1 : 0
  oauth_client_id = var.oauth_client_id
}

locals {
  terraform_variables = [for v in var.terraform_variables :
    {
      key         = v.key
      value       = v.value
      category    = "terraform"
      description = try(v.description, null)
    }
  ]

  terraform_hcl_variables = [for v in var.terraform_hcl_variables :
    {
      key         = v.key
      value       = v.value
      category    = "terraform"
      hcl         = true
      description = try(v.description, null)
    }
  ]

  terraform_sensitive_variables = [for v in var.terraform_sensitive_variables :
    {
      key         = v.key
      value       = v.value
      category    = "terraform"
      description = try(v.description, null)
      sensitive   = true
    }
  ]

  terraform_hcl_sensitive_variables = [for v in var.terraform_hcl_sensitive_variables :
    {
      key         = v.key
      value       = v.value
      category    = "terraform"
      description = try(v.description, null)
      hcl         = true
      sensitive   = true
    }
  ]

  environment_variables = [for v in var.environment_variables :
    {
      key         = v.key
      value       = v.value
      category    = "env"
      description = try(v.description, null)
    }
  ]

  environment_sensitive_variables = [for v in var.environment_sensitive_variables :
    {
      key         = v.key
      value       = v.value
      category    = "env"
      description = try(v.description, null)
      sensitive   = true
    }
  ]

  all_variables = flatten([
    local.terraform_variables,
    local.terraform_hcl_variables,
    local.terraform_sensitive_variables,
    local.terraform_hcl_sensitive_variables,
    local.environment_variables,
    local.environment_sensitive_variables
  ])
}

resource "tfe_workspace" "this" {
  name                          = var.name
  organization                  = var.organization
  description                   = var.description
  allow_destroy_plan            = var.allow_destroy_plan
  auto_apply                    = var.auto_apply
  execution_mode                = var.execution_mode
  file_triggers_enabled         = var.file_triggers_enabled
  global_remote_state           = var.global_remote_state
  remote_state_consumer_ids     = var.remote_state_consumer_ids
  queue_all_runs                = var.queue_all_runs
  speculative_enabled           = var.speculative_enabled
  structured_run_output_enabled = var.structured_run_output_enabled
  ssh_key_id                    = var.ssh_key_id
  terraform_version             = var.terraform_version
  trigger_prefixes              = var.trigger_prefixes
  tag_names                     = var.tag_names
  working_directory             = var.working_directory

  dynamic "vcs_repo" {
    for_each = length(var.vcs_repository_identifier) > 0 && can(data.tfe_oauth_client.this[0].oauth_token_id) ? [1] : []

    content {
      identifier         = var.vcs_repository_identifier
      branch             = var.vcs_repository_branch
      ingress_submodules = var.vcs_repository_ingress_submodules
      oauth_token_id     = try(data.tfe_oauth_client.this[0].oauth_token_id, null)
    }
  }
}

resource "tfe_variable" "this" {
  count = length(local.all_variables)

  key          = lookup(local.all_variables[count.index], "key")
  value        = lookup(local.all_variables[count.index], "value")
  hcl          = try(lookup(local.all_variables[count.index], "hcl"), null)
  category     = lookup(local.all_variables[count.index], "category")
  description  = try(lookup(local.all_variables[count.index], "description"), null)
  sensitive    = try(lookup(local.all_variables[count.index], "sensitive"), false)
  workspace_id = tfe_workspace.this.id
}
