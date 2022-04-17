data "tfe_oauth_client" "this" {
  count           = var.oauth_client_id ? 1 : 0
  oauth_client_id = var.oauth_client_id
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
  trigger_prefix                = var.trigger_prefix
  tag_names                     = var.tag_names
  working_directory             = var.working_directory

  dynamic "vcs_repo" {
    for_each = length(var.vcs_repository_identifier) > 0 ? [1] : []

    content {
      identifier         = var.vcs_repository_identifier
      branch             = var.vcs_repository_branch
      ingress_submodules = var.vcs_repository_ingress_submodules
      oauth_token_id     = try(tfe_oauth_client.this.oauth_token_id[0], null)
    }
  }
}
